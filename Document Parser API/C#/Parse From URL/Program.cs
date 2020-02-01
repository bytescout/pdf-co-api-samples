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


using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Net;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ByteScoutWebApiExample
{
    class Program
    {
        // The authentication key (API Key).
        // Get your own by registering at https://app.pdf.co/documentation/api
        const String API_KEY = "***********************************";

        // Source PDF file
        const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/document-parser/MultiPageTable.pdf";

        // Destination TXT file name
        const string DestinationFile = @".\result.json";

        static void Main(string[] args)
        {
            // Template text. Use Document Parser SDK (https://bytescout.com/products/developer/documentparsersdk/index.html)
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

                // URL for `Document Parser` API call
                string query = Uri.EscapeUriString(string.Format(
                    "https://api.pdf.co/v1/pdf/documentparser?url={0}",
                    SourceFileUrl));

                Dictionary<string, string> requestBody = new Dictionary<string, string>();
                requestBody.Add("template", templateText);

                // Execute request
                string response = webClient.UploadString(query, "POST", JsonConvert.SerializeObject(requestBody));

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
