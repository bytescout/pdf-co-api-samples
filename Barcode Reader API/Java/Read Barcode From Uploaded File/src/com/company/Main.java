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

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import okhttp3.*;

import java.io.*;
import java.net.*;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Main
{
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co
    final static String API_KEY = "***********************************";

    // Source file name
    final static Path SourceFile = Paths.get(".\\sample.pdf");
    // Comma-separated list of barcode types to search.
    // See valid barcode types in the documentation https://apidocs.pdf.co
    final static String BarcodeTypes = "Code128,Code39,Interleaved2of5,EAN13";
    // Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
    final static String Pages = "";


    public static void main(String[] args) throws IOException
    {
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

                // 2. UPLOAD THE FILE TO CLOUD.

                if (uploadFile(webClient, uploadUrl, SourceFile.toFile()))
                {
                    // 3. READ BARCODES FROM UPLOADED FILE

                    readBarcodes(webClient, uploadedFileUrl, BarcodeTypes, Pages);
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

    public static void readBarcodes(OkHttpClient webClient, String uploadedFileUrl, String barcodeTypes, String pages) throws IOException {
        // Prepare URL for `Barcode Reader` API call
        String query = "https://api.pdf.co/v1/barcode/read/from/url";

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
        String jsonPayload = String.format("{\"types\": \"%s\", \"pages\": \"%s\", \"url\": \"%s\"}",
            barcodeTypes,
            pages,
            uploadedFileUrl);

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
                // Display found barcodes in console
                for (JsonElement element : json.get("barcodes").getAsJsonArray())
                {
                    JsonObject barcode = (JsonObject) element;
                    System.out.println("Found barcode:");
                    System.out.println("  Type: " + barcode.get("TypeName").getAsString());
                    System.out.println("  Value: " + barcode.get("Value").getAsString());
                    System.out.println("  Document Page Index: " + barcode.get("Page").getAsString());
                    System.out.println("  Rectangle: " + barcode.get("Rect").getAsString());
                    System.out.println("  Confidence: " + barcode.get("Confidence").getAsString());
                    System.out.println();
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

    public static boolean uploadFile(OkHttpClient webClient, String url, File sourceFile) throws IOException
    {
        // Prepare request body
        RequestBody body = RequestBody.create(MediaType.parse("application/octet-stream"), sourceFile);

        // Prepare request
        Request request = new Request.Builder()
                .url(url)
                .addHeader("x-api-key", API_KEY) // (!) Set API Key
                .addHeader("content-type", "application/octet-stream")
                .put(body)
                .build();

        // Execute request
        Response response = webClient.newCall(request).execute();

        return (response.code() == 200);
    }
}
