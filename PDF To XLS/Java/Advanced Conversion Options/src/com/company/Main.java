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

public class Main
{
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co
    final static String API_KEY = "***********************************";

    // Direct URL of source PDF file.
    // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
    final static String SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-excel/sample.pdf";
    // Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
    final static String Pages = "";
    // PDF document password. Leave empty for unprotected documents.
    final static String Password = "";
    // Destination XLS file name
    final static Path DestinationFile = Paths.get(".\\result.xls");


    public static void main(String[] args) throws IOException
    {
        // Create HTTP client instance
        OkHttpClient webClient = new OkHttpClient();

        /*
        Some of advanced options available through profiles:
        (JSON can be single/double-quoted and contain comments.)
        {
            "profiles": [
                {
                    "profile1": {
                        "NumberDecimalSeparator": "", // Allows to customize decimal separator in numbers.
                        "NumberGroupSeparator": "", // Allows to customize thousands separator.
                        "AutoDetectNumbers": true, // Whether to detect numbers. Values: true / false
                        "RichTextFormatting": true, // Whether to keep text style and fonts. Values: true / false
                        "PageToWorksheet": true, // Whether to create separate worksheet for each page of PDF document. Values: true / false
                        "ExtractInvisibleText": true, // Invisible text extraction. Values: true / false
                        "ExtractShadowLikeText": true, // Shadow-like text extraction. Values: true / false
                        "LineGroupingMode": "None", // Values: "None", "GroupByRows", "GroupByColumns", "JoinOrphanedRows"
                        "ColumnDetectionMode": "ContentGroupsAndBorders", // Values: "ContentGroupsAndBorders", "ContentGroups", "Borders", "BorderedTables"
                        "Unwrap": false, // Unwrap grouped text in table cells. Values: true / false
                        "ShrinkMultipleSpaces": false, // Shrink multiple spaces in table cells that affect column detection. Values: true / false
                        "DetectNewColumnBySpacesRatio": 1, // Spacing ratio that affects column detection.
                        "CustomExtractionColumns": [ 0, 50, 150, 200, 250, 300 ], // Explicitly specify columns coordinates for table extraction.
                        "CheckPermissions": true, // Ignore document permissions. Values: true / false
                    }
                }
            ]
        }
        */
        // Sample profile that sets advanced conversion options.
        // Advanced options are properties of XLSExtractor class from ByteScout PDF Extractor SDK used in the back-end:
        // https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/2712c05b-9674-5253-df76-2a31ed055afd.htm
        String Profiles = "{ 'profiles': [ { 'profile1': { 'RichTextFormatting': false, 'PageToWorksheet': false } } ] }";


        // Prepare URL for `PDF To XLS` API call
        String query = "https://api.pdf.co/v1/pdf/convert/to/xls";

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
		String jsonPayload = String.format("{\"name\": \"%s\", \"password\": \"%s\", \"pages\": \"%s\", \"url\": \"%s\", \"profiles\": \"%s\"}",
                DestinationFile.getFileName(),
                Password,
                Pages,
                SourceFileUrl,
                Profiles);

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
                // Get URL of generated XLS file
                String resultFileUrl = json.get("url").getAsString();

                // Download XLS file
                downloadFile(webClient, resultFileUrl, DestinationFile.toFile());

                System.out.printf("Generated XLS file saved as \"%s\" file.", DestinationFile.toString());
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
