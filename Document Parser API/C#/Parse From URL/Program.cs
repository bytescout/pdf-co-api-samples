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


using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;

namespace ByteScoutWebApiExample
{
    class Program
    {
        // The authentication key (API Key).
        // Get your own by registering at https://app.pdf.co
        const String API_KEY = "***********************************";

        // Source PDF file
        // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
        const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/document-parser/MultiPageTable.pdf";

        // Destination TXT file name
        const string DestinationFile = @".\result.json";

        static void Main(string[] args)
        {
            // Template text. Use Document Parser (https://pdf.co/document-parser, https://app.pdf.co/document-parser)
            // to create templates.
            // Read template from file:
            String templateText = File.ReadAllText(@".\MultiPageTable-template1.yml");

            // Create standard .NET web client instance
            WebClient webClient = new WebClient();

            // Set API Key
            webClient.Headers.Add("x-api-key", API_KEY);

            try
            {
                // PARSE UPLOADED PDF DOCUMENT

                // URL of `Document Parser` API call
                string url = "https://api.pdf.co/v1/pdf/documentparser";

                Dictionary<string, string> requestBody = new Dictionary<string, string>();
                requestBody.Add("template", templateText);
                requestBody.Add("name", Path.GetFileName(DestinationFile));
                requestBody.Add("url", SourceFileUrl);

                // Convert dictionary of params to JSON
                string jsonPayload = JsonConvert.SerializeObject(requestBody);

                // Execute request
                string response = webClient.UploadString(url, "POST", jsonPayload);

                // Parse response
                JObject json = JObject.Parse(response);

                if (json["error"].ToObject<bool>() == false)
                {
                    // Get URL of generated JSON file
                    string resultFileUrl = json["url"].ToString();

                    // Download JSON file
                    webClient.DownloadFile(resultFileUrl, DestinationFile);

                    Console.WriteLine("Generated JSON file saved as \"{0}\" file.", DestinationFile);
                }
                else
                {
                    Console.WriteLine(json["message"].ToString());
                }
            }
            catch (WebException e)
            {
                Console.WriteLine(e.ToString());
            }

            webClient.Dispose();

            Console.WriteLine();
            Console.WriteLine("Press any key...");
            Console.ReadKey();
        }
    }
}
