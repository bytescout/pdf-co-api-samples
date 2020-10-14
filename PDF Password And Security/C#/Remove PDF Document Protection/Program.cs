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
        // Get your own by registering at https://app.pdf.co/documentation/api
        const String API_KEY = "***********************************";
        

        // Source PDF file url
        const string SourceFileUrl = @"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-security/ProtectedPDFFile.pdf";

        // The owner/user password to open file and to remove security features
        const string PDFFilePassword = "admin@123";

        // Destination file
        const string DestinationFile = "./unprotected.pdf";


        static void Main(string[] args)
        {
            // Runs processing asynchronously. 
            // Returns Use JobId that you may use with /job/check to check state of the processing (possible states: working, failed, aborted and success).
            var async = false; 

            // Create standard .NET web client instance
            WebClient webClient = new WebClient();

            // Set API Key
            webClient.Headers.Add("x-api-key", API_KEY);


            // Remove Security from PDF DOCUMENT

            // Prepare requests params as JSON
            // See documentation: https://apidocs.pdf.co
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("name", Path.GetFileName(DestinationFile));
            parameters.Add("url", SourceFileUrl);
            parameters.Add("password", PDFFilePassword);
            parameters.Add("async", async);

            // Convert dictionary of params to JSON
            string jsonPayload = JsonConvert.SerializeObject(parameters);

            try
            {
                // URL of "Remove PDF Security" endpoint
                string url = "https://api.pdf.co/v1/pdf/security/remove";

                // Execute POST request with JSON payload
                string response = webClient.UploadString(url, jsonPayload);

                // Parse JSON response
                JObject json = JObject.Parse(response);

                if (json["error"].ToObject<bool>() == false)
                {
                    // Get URL of generated PDF file
                    string resultFileUrl = json["url"].ToString();

                    // Download generated PDF file
                    webClient.DownloadFile(resultFileUrl, DestinationFile);

                    Console.WriteLine("Generated PDF file saved as \"{0}\" file.", DestinationFile);
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
