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
using System.Net;

namespace ByteScoutWebApiExample
{
    class Program
    {
        // The authentication key (API Key).
        // Get your own by registering at https://app.pdf.co/documentation/api
        const String API_KEY = "**************************";

        // Direct URL of source PDF file.
        const string SourceFileUrl = "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf";
        // PDF document password. Leave empty for unprotected documents.
        const string Password = "";
        // File name for generated output. Must be a String
        const string FileName = "newDocument";

        // Destination File Name
        const string DestinationFile = "./result.pdf";

        static void Main(string[] args)
        {
            // Create standard .NET web client instance
            WebClient webClient = new WebClient();

            // Set API Key
            webClient.Headers.Add("x-api-key", API_KEY);

            // Controls to be added
            var annotations = new List<object> {
                new { text = "sample prefilled text", x = 10, y =30, size = 12, pages = "0-", type = "TextField", id ="textfield1" },
                new { x = 100, y =150, size = 12, pages = "0-", type = "Checkbox", id ="checkbox2" },
                new { x = 100, y =170, size = 12, pages = "0-", link = "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png", type = "CheckboxChecked", id ="checkbox3" }
            };

            // If enabled, Runs processing asynchronously. Returns Use JobId that you may use with /job/check to check state of the processing (possible states: working, 
            var async = false;

            // Prepare requests params as JSON
            // See documentation: https://apidocs.pdf.co
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("url", SourceFileUrl);
            parameters.Add("name", FileName);
            parameters.Add("password", Password);
            parameters.Add("async", async);
            parameters.Add("annotations", annotations);

            // Convert dictionary of params to JSON
            string jsonPayload = JsonConvert.SerializeObject(parameters);

            try
            {
                // URL of "PDF Edit" endpoint
                string url = "https://api.pdf.co/v1/pdf/edit/add";

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
            finally
            {
                webClient.Dispose();
            }

            Console.WriteLine();
            Console.WriteLine("Press any key...");
            Console.ReadKey();
        }
    }
}
