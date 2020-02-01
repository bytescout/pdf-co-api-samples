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
using System.IO;
using System.Net;
using Newtonsoft.Json.Linq;

namespace ByteScoutWebApiExample
{
	class Program
	{
		// The authentication key (API Key).
		// Get your own by registering at https://app.pdf.co/documentation/api
		const String API_KEY = "*****************************************";
		
		// Direct URL of source PDF file.
		const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf";
		
		// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
		const string Pages = "";
		
		// PDF document password. Leave empty for unprotected documents.
		const string Password = "";
		
		// Search string. 
		const string SearchString = @"\d{1,}\.\d\d"; // Regular expression to find numbers like '100.00'
		// Note: do not use `+` char in regex, but use `{1,}` instead.
		// `+` char is valid for URL and will not be escaped, and it will become a space char on the server side.
        
		// Enable regular expressions (Regex) 
        const bool RegexSearch = true;


        static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

            // Prepare URL for PDF text search API call.
            // See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html
            string query = Uri.EscapeUriString(string.Format(
                "https://api.pdf.co/v1/pdf/find?password={0}&pages={1}&url={2}&searchString={3}&regexSearch={4}", 
				Password,
				Pages,
				SourceFileUrl,
                SearchString,
                RegexSearch));

			try
			{
				// Execute request
				string response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["status"].ToString() != "error")
                {
                    foreach (JToken item in json["body"])
                    {
                        Console.WriteLine($"Found text \"{item["text"]}\" at coordinates {item["left"]}, {item["top"]}");
                    }
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
