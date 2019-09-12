//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2019 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//


using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Threading;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

// Cloud API asynchronous "Document Parser" job example.
// Allows to avoid timeout errors when processing huge or scanned PDF documents.

namespace ByteScoutWebApiExample
{
    class Program
    {
        // The authentication key (API Key).
        // Get your own by registering at https://app.pdf.co/documentation/api
        const string API_KEY = "***********************************";

        // Source PDF file
        const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/document-parser/MultiPageTable.pdf";

        // Destination TXT file name
        const string DestinationFile = @".\result.json";

        // (!) Make asynchronous job
        const bool Async = true;


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
                    "https://api.pdf.co/v1/pdf/documentparser?url={0}&async={1}",
                    SourceFileUrl,
                    Async));

                Dictionary<string, string> requestBody = new Dictionary<string, string>();
                requestBody.Add("template", templateText);

                // Execute request
                string response = webClient.UploadString(query, "POST", JsonConvert.SerializeObject(requestBody));

                // Parse response
                JObject json = JObject.Parse(response);

                if (json["error"].ToObject<bool>() == false)
                {
                    // Asynchronous job ID
                    string jobId = json["jobId"].ToString();
                    // Get URL of generated JSON file
                    string resultFileUrl = json["url"].ToString();

                    // Check the job status in a loop. 
                    // If you don't want to pause the main thread you can rework the code 
                    // to use a separate thread for the status checking and completion.
                    do
                    {
                        string status = CheckJobStatus(webClient, jobId); // Possible statuses: "working", "failed", "aborted", "success".

                        // Display timestamp and status (for demo purposes)
                        Console.WriteLine(DateTime.Now.ToLongTimeString() + ": " + status);

                        if (status == "success")
                        {
                            // Download JSON file
                            webClient.DownloadFile(resultFileUrl, DestinationFile);

                            Console.WriteLine("Generated JSON file saved as \"{0}\" file.", DestinationFile);
                            break;
                        }
                        else if (status == "working")
                        {
                            // Pause for a few seconds
                            Thread.Sleep(3000);
                        }
                        else 
                        {
                            Console.WriteLine(status);
                            break;
                        }
                    }
                    while (true);
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

        static string CheckJobStatus(WebClient webClient, string jobId)
        {
            string url = "https://api.pdf.co/v1/job/check?jobid=" + jobId;

            string response = webClient.DownloadString(url);
            JObject json = JObject.Parse(response);

            return Convert.ToString(json["status"]);
        }
    }
}
