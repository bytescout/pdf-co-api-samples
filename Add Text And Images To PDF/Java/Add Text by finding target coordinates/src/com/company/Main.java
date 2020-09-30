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
    // Get your own by registering at https://app.pdf.co/documentation/api
    final static String API_KEY = "***********************************";

    // Direct URL of source PDF file.
    final static String SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf";
    // Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
	final static String Pages = "";
    // PDF document password. Leave empty for unprotected documents.
	final static String Password = "";

    // Destination PDF file name
	final static Path ResultFile = Paths.get(".\\result.pdf");

    // Annotation params
    private final static String Type = "annotation";
    private final static String Text = "Some notes will go here... Some notes will go here.... Some notes will go here.....";
    private final static String FontName = "Times New Roman";
    private final static float FontSize = 12;
    private final static String Color = "FF0000";

    public static void main(String[] args) throws IOException
    {
        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        // Find Text coordinates to add Annotation
        ResultCoOrdinates oCoordinates = FindCoordinates(API_KEY, SourceFileUrl, "Notes");

        int X = oCoordinates.x;
        int Y = oCoordinates.y + 25;


        // * Add text annotations *
        // Prepare URL for `PDF Edit` API call
        String query = "https://api.pdf.co/v1/pdf/edit/add";

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
        String jsonPayload = String.format("{\"name\": \"%s\", \"password\": \"%s\", \"pages\": \"%s\", \"url\": \"%s\", \"type\": \"%s\", \"x\": \"%s\", \"y\": \"%s\", \"text\": \"%s\", \"fontname\": \"%s\", \"size\": \"%s\", \"color\": \"%s\"}",
        ResultFile.getFileName(),
                Password,
                Pages,
                SourceFileUrl,
                Type,
                X,
                Y,
                Text,
                FontName,
                FontSize,
                Color);

        // Prepare request body
        RequestBody body = RequestBody.create(MediaType.parse("application/json"), jsonPayload);

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
                // Get URL of generated output file
                String resultFileUrl = json.get("url").getAsString();

                // Download the image file
                downloadFile(webClient, resultFileUrl, ResultFile);

                System.out.printf("Generated file saved to \"%s\" file.", ResultFile.toString());
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

    public static void downloadFile(OkHttpClient webClient, String url, Path destinationFile) throws IOException
    {
        // Prepare request
        Request request = new Request.Builder()
                .url(url)
                .build();
        // Execute request
        Response response = webClient.newCall(request).execute();

        byte[] fileBytes = response.body().bytes();

        // Save downloaded bytes to file
        OutputStream output = new FileOutputStream(destinationFile.toFile());
        output.write(fileBytes);
        output.flush();
        output.close();

        response.close();
    }


    public static ResultCoOrdinates FindCoordinates(String API_KEY, String SourceFileURL, String SearchString) throws IOException {

        ResultCoOrdinates oResult = new ResultCoOrdinates();

        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        // Prepare URL for PDF text search API call.
        // See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html
        String query = "https://api.pdf.co/v1/pdf/find";

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
        catch (MalformedURLException e) {
            e.printStackTrace();
        }

        // Create JSON payload
        String jsonPayload = String.format("{\"url\": \"%s\", \"searchString\": \"%s\"}", SourceFileURL, SearchString);

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
                JsonObject item = (JsonObject) json.get("body").getAsJsonArray().get(0);

                oResult.x = item.get("left").getAsInt();
                oResult.y = item.get("top").getAsInt();
                oResult.width = item.get("width").getAsInt();
                oResult.height = item.get("height").getAsInt();
            }
        }
        else
        {
            // Display request error
            System.out.println(response.code() + " " + response.message());
        }

        return oResult;
    }

}

class ResultCoOrdinates{

    public int x;
    public int y;
    public int width;
    public int height;
}
