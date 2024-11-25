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
using System.Threading;

namespace ByteScoutWebApiExample
{
	class Program
	{
		// The authentication key (API Key).
		// Get your own by registering at https://app.pdf.co
		const String API_KEY = "***********************************";

        // Direct URL of Source PDF file
        // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
        const string SourceFileURL = "https://pdfco-test-files.s3.us-west-2.amazonaws.com/document-parser/sample-invoice.pdf";
		
		static void Main(string[] args)
		{
            // Create standard .NET web client instance
            WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

            // URL for `AI Invoice Parser` API call
            string url = "https://api.pdf.co/v1/ai-invoice-parser";

			// Prepare requests params as JSON
			Dictionary<string, object> parameters = new Dictionary<string, object>();
			parameters.Add("url", SourceFileURL);

			// Convert dictionary of params to JSON
			string jsonPayload = JsonConvert.SerializeObject(parameters);

            try
            {
                // Execute POST request with JSON payload
                string response = webClient.UploadString(url, jsonPayload);

                // Parse JSON response
                JObject json = JObject.Parse(response);

                if (json["error"].ToObject<bool>() == false)
                {
                    // Asynchronous job ID
                    string jobId = json["jobId"].ToString();

                    // Check the job status in a loop. 
                    // If you don't want to pause the main thread you can rework the code 
                    // to use a separate thread for the status checking and completion.
                    do
                    {
                        string job_response = "";
                        string status = CheckJobStatus(jobId, out job_response); // Possible statuses: "working", "failed", "aborted", "success".

                        // Display timestamp and status (for demo purposes)
                        Console.WriteLine(DateTime.Now.ToLongTimeString() + ": " + status);

                        if (status == "success")
                        {
                            Console.WriteLine("** Final Response **");
                            Console.WriteLine(job_response);
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

        static string CheckJobStatus(string jobId, out string response)
        {
            using (WebClient webClient = new WebClient())
            {
                // Set API Key
                webClient.Headers.Add("x-api-key", API_KEY);

                string url = "https://api.pdf.co/v1/job/check?jobid=" + jobId;

                response = webClient.DownloadString(url);
                JObject json = JObject.Parse(response);

                return Convert.ToString(json["status"]);
            }
        }
    }
}
