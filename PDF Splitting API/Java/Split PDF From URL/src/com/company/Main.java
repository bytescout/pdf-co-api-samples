//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Free Trial Sign Up: https://secure.bytescout.com/users/sign_up //
//                                                                                           //
// Copyright © 2017-2018 ByteScout Inc. All rights reserved.                                 //
// http://www.bytescout.com                                                                  //
//                                                                                           //
//*******************************************************************************************//


package com.company;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import okhttp3.*;

import java.io.*;
import java.nio.file.Paths;

public class Main
{
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co/documentation/api
    final static String API_KEY = "***********************************";

    // Source PDF file to split
	final static String SourceFileUrl = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/pdf-split/sample.pdf";
    // Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
    final static String Pages = "1-2,3-";


    public static void main(String[] args) throws IOException
    {
        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        // Prepare URL for `Split PDF` API call
        String query = String.format(
                "https://api.pdf.co/v1/pdf/split?&pages=%s&url=%s",
                Pages,
                SourceFileUrl);

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
                // Download generated PDF files
                JsonArray urls = json.get("urls").getAsJsonArray();

                int part = 1;
                for (JsonElement element: urls)
                {
                    String resultFileUrl = element.getAsString();
                    String localFileName = String.format(".\\part%s.pdf", part);

                    downloadFile(webClient, resultFileUrl, Paths.get(localFileName).toFile());

                    System.out.println(String.format("Splitted part saved as \"%s\".", localFileName));
                    part++;
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
