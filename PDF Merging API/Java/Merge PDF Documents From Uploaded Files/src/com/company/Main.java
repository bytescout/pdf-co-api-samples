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
import okhttp3.*;

import java.io.*;
import java.net.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class Main
{
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co
    final static String API_KEY = "***********************************";

    // Source PDF files
    final static Path[] SourceFiles = new Path[] {
            Paths.get(".\\sample1.pdf"),
            Paths.get(".\\sample2.pdf") };
    // Destination PDF file name
    final static Path DestinationFile = Paths.get(".\\result.pdf");


    public static void main(String[] args) throws IOException
    {
        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        // 1. UPLOAD FILES TO CLOUD

        ArrayList<String> uploadedFiles = new ArrayList<>();

        for (Path pdfFile : SourceFiles)
        {
            // 1a. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.

            // Prepare URL for `Get Presigned URL` API call
            String query = String.format(
                    "https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=%s",
                    pdfFile.getFileName());

            // Prepare request
            Request request = new Request.Builder()
                    .url(query)
                    .addHeader("x-api-key", API_KEY) // (!) Set API Key
                    .build();
            // Execute request
            Response response = webClient.newCall(request).execute();

            if (response.code() == 200)
            {
                // Parse JSON response
                JsonObject json = new JsonParser().parse(response.body().string()).getAsJsonObject();

                boolean error = json.get("error").getAsBoolean();
                if (!error)
                {
                    // Get URL to use for the file upload
                    String uploadUrl = json.get("presignedUrl").getAsString();
                    // Get URL of uploaded file to use with later API calls
                    String uploadedFileUrl = json.get("url").getAsString();

                    // 1b. UPLOAD THE FILE TO CLOUD.

                    if (uploadFile(webClient, API_KEY, uploadUrl, pdfFile))
                    {
                        uploadedFiles.add(uploadedFileUrl);
                    }
                }
                else
                {
                    // Display service reported error
                    System.out.println(json.get("message").getAsString());
                }
            }
            else
            {
                // Display request error
                System.out.println(response.code() + " " + response.message());
            }
        }


        if (uploadedFiles.size() > 0)
        {
            // 2. MERGE UPLOADED PDF DOCUMENTS

            MergePdfDocuments(webClient, API_KEY, DestinationFile, uploadedFiles);
        }
    }

    public static void MergePdfDocuments(OkHttpClient webClient, String apiKey, Path destinationFile, List<String> uploadedFileUrls) throws IOException
    {
        // Prepare URL for `Merge PDF` API call
        String query = "https://api.pdf.co/v1/pdf/merge";

        // Make correctly escaped (encoded) URL
        URL url = null;
        try
        {
            url = new URI(null, query, null).toURL();
        }
        catch (URISyntaxException e)
        {
            e.printStackTrace();
        }

        // Create JSON payload
		String jsonPayload = String.format("{\"name\": \"%s\", \"url\": \"%s\"}",
                destinationFile.getFileName(),
                String.join(",", uploadedFileUrls));

        // Prepare request body
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), jsonPayload);
        
        // Prepare request
        Request request = new Request.Builder()
            .url(url)
            .addHeader("x-api-key", API_KEY) // (!) Set API Key
            .addHeader("Content-Type", "application/json")
            .post(body)
            .build();
        
        // Execute request
        Response response = webClient.newCall(request).execute();

        if (response.code() == 200)
        {
            // Parse JSON response
            JsonObject json = new JsonParser().parse(response.body().string()).getAsJsonObject();

            boolean error = json.get("error").getAsBoolean();
            if (!error)
            {
                // Get URL of generated PDF file
                String resultFileUrl = json.get("url").getAsString();

                // Download PDF file
                downloadFile(webClient, resultFileUrl, destinationFile.toFile());

                System.out.printf("Generated PDF file saved as \"%s\" file.", destinationFile.toString());
            }
            else
            {
                // Display service reported error
                System.out.println(json.get("message").getAsString());
            }
        }
        else
        {
            // Display request error
            System.out.println(response.code() + " " + response.message());
        }
    }

    public static boolean uploadFile(OkHttpClient webClient, String apiKey, String url, Path sourceFile) throws IOException
    {
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

    public static void downloadFile(OkHttpClient webClient, String url, File destinationFile) throws IOException
    {
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
