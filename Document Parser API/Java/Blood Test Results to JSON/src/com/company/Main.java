//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
//                                                                                           //
//*******************************************************************************************//


package com.company;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;
import okhttp3.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Main {
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co
    final static String API_KEY = "********************************";

    // (!) Make asynchronous job
    final static boolean Async = true;

    public static void main(String[] args) throws IOException {


        // Sample document containing blood test report
        // Report consists of sample patient information such as patient name, DOB, patientID
        // Report information such as report type, collection date and time
        // Test components such as complete blood count, Hemoglobin, White Blood Cell (WBC), Red Blood Cell (RBC), etc.
        final Path SourceFile = Paths.get(".\\SampleBloodReport.pdf");

        // PDF document password. Leave empty for unprotected documents.
        final String Password = "";

        // Destination JSON file name
        final Path DestinationFile = Paths.get(".\\result.json");

        // Template text. Use Document Parser (https://pdf.co/document-parser, https://app.pdf.co/document-parser)
        // to create templates.
        // Read template from file:
        // Sample template which primarily extracts patient name, report date and test result table.
        String templateText = new String(Files.readAllBytes(Paths.get(".\\SampleBloodReport.yml")), StandardCharsets.UTF_8);

        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        // 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
        // * If you already have a direct file URL, skip to the step 3.

        // Prepare URL for `Get Presigned URL` API call
        String query = String.format(
                "https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=%s",
                SourceFile.getFileName());

        // Prepare request
        Request request = new Request.Builder()
                .url(query)
                .addHeader("x-api-key", API_KEY) // (!) Set API Key
                .build();
        // Execute request
        Response response = webClient.newCall(request).execute();

        if (response.code() == 200) {
            // Parse JSON response
            JsonObject json = new JsonParser().parse(response.body().string()).getAsJsonObject();

            boolean error = json.get("error").getAsBoolean();
            if (!error) {
                // Get URL to use for the file upload
                String uploadUrl = json.get("presignedUrl").getAsString();
                // Get URL of uploaded file to use with later API calls
                String uploadedFileUrl = json.get("url").getAsString();

                // 2. UPLOAD THE FILE TO CLOUD.
                if (uploadFile(webClient, API_KEY, uploadUrl, SourceFile)) {

                    // 3. PARSE UPLOADED PDF DOCUMENT
                    ParseDocument(webClient, API_KEY, DestinationFile, Password, uploadedFileUrl, templateText);
                }
            } else {
                // Display service reported error
                System.out.println(json.get("message").getAsString());
            }
        } else {
            // Display request error
            System.out.println(response.code() + " " + response.message());
        }
    }

    public static void ParseDocument(OkHttpClient webClient, String apiKey, Path destinationFile,
                                     String password, String uploadedFileUrl, String templateText) throws IOException {
        // Prepare POST request body in JSON format
        JsonObject jsonBody = new JsonObject();
        jsonBody.add("url", new JsonPrimitive(uploadedFileUrl));
        jsonBody.add("template", new JsonPrimitive(templateText));

        RequestBody body = RequestBody.create(MediaType.parse("application/json"), jsonBody.toString());

        // Prepare URL for Document parser API call.
        // See documentation: https://apidocs.pdf.co/?#1-pdfdocumentparser
        String query = String.format("https://api.pdf.co/v1/pdf/documentparser?async=%s", Async);

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");

        // Prepare request to `Document Parser` API
        Request request = new Request.Builder()
                .url(query)
                .addHeader("x-api-key", API_KEY) // (!) Set API Key
                .addHeader("Content-Type", "application/json")
                .post(body)
                .build();

        // Execute request
        Response response = webClient.newCall(request).execute();

        if (response.code() == 200) {
            // Parse JSON response
            JsonObject json = new JsonParser().parse(response.body().string()).getAsJsonObject();

            boolean error = json.get("error").getAsBoolean();
            if (!error) {
                // Asynchronous job ID
                String jobId = json.get("jobId").getAsString();

                System.out.println("Job#" + jobId + ": has been created. - " + dtf.format(LocalDateTime.now()));

                // URL of generated json file that will available after the job completion
                String resultFileUrl = json.get("url").getAsString();

                // Check the job status in a loop.
                // If you don't want to pause the main thread you can rework the code
                // to use a separate thread for the status checking and completion.
                do {

                    String status = CheckJobStatus(webClient, jobId); // Possible statuses: "working", "failed", "aborted", "success"

                    System.out.println("Job#" + jobId + ": " + status + " - " + dtf.format(LocalDateTime.now()));

                    if (status.compareToIgnoreCase("success") == 0) {

                        // Download JSON file
                        downloadFile(webClient, resultFileUrl, destinationFile.toFile());

                        System.out.printf("Generated JSON file saved as \"%s\" file.", destinationFile.toString());

                        break;

                    } else if (status.compareToIgnoreCase("working") == 0) {
                        // Pause for a few seconds
                        try {
                            Thread.sleep(3000);
                        } catch (InterruptedException ex) {
                            Thread.currentThread().interrupt(); // restore interrupted status
                        }
                    } else {
                        System.out.println(status);
                        break;
                    }
                } while (true);

            } else {
                // Display service reported error
                System.out.println(json.get("message").getAsString());
            }
        } else {
            // Display request error
            System.out.println(response.code() + " " + response.message());
        }
    }


    // Check Job Status
    private static String CheckJobStatus(OkHttpClient webClient, String jobId) throws IOException {

        String url = "https://api.pdf.co/v1/job/check?jobid=" + jobId;

        // Prepare request
        Request request = new Request.Builder()
                .url(url)
                .addHeader("x-api-key", API_KEY) // (!) Set API Key
                .build();

        // Execute request
        Response response = webClient.newCall(request).execute();

        if (response.code() == 200) {
            // Parse JSON response
            JsonObject json = new JsonParser().parse(response.body().string()).getAsJsonObject();

            return json.get("status").getAsString();
        } else {
            // Display request error
            System.out.println(response.code() + " " + response.message());
        }

        return "Failed";
    }


    public static boolean uploadFile(OkHttpClient webClient, String apiKey, String url, Path sourceFile) throws IOException {
        // Prepare request body
        RequestBody body = RequestBody.create(MediaType.parse("application/octet-stream"), sourceFile.toFile());

        // Prepare request
        Request request = new Request.Builder()
                .url(url)
                .addHeader("x-api-key", apiKey) // (!) Set API Key
                .addHeader("content-type", "application/octet-stream")
                .put(body)
                .build();

        // Execute request
        Response response = webClient.newCall(request).execute();

        return (response.code() == 200);
    }

    public static void downloadFile(OkHttpClient webClient, String url, File destinationFile) throws IOException {
        // Prepare request
        Request request = new Request.Builder()
                .url(url)
                .build();
        // Execute request
        Response response = webClient.newCall(request).execute();

        byte[] fileBytes = response.body().bytes();

        // Save downloaded bytes to file
        OutputStream output = new FileOutputStream(destinationFile);
        output.write(fileBytes);
        output.flush();
        output.close();

        response.close();
    }
}
