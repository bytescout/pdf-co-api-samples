//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
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

public class Main
{
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co/documentation/api
    final static String API_KEY = "***********************************";

    // URL of web page to convert to PDF document.
    final static String SourceUrl = "http://www.usa.gov";
    // Destination PDF file name
    final static Path DestinationFile = Paths.get(".\\result.pdf");


    public static void main(String[] args) throws IOException
    {
        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        // Prepare URL for `Web Page to PDF` API call
        String query = String.format(
                "https://api.pdf.co/v1/pdf/convert/from/url?name=%s&url=%s",
                DestinationFile.getFileName(),
                SourceUrl);

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

        // Prepare request
        Request request = new Request.Builder()
                .url(url)
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
                // Get URL of generated PDF file
                String resultFileUrl = json.get("url").getAsString();

                // Download PDF file
                downloadFile(webClient, resultFileUrl, DestinationFile.toFile());

                System.out.printf("Generated PDF file saved as \"%s\" file.", DestinationFile.toString());
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
