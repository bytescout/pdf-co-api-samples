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
		const String API_KEY = "***********************************";

        // Direct URL of source PDF file.
        const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf";
		// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
		const string Pages = "";
		// PDF document password. Leave empty for unprotected documents.
		const string Password = "";
		// Destination TXT file name
		const string DestinationFile = @".\result.txt";

        // Sample profile that sets advanced conversion options
        // Advanced options are properties of TextExtractor class from ByteScout Text Extractor SDK used in the back-end:
        // https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/8a2bae5a-346f-8338-b5aa-6f3522dca0d4.htm
        static string Profiles = File.ReadAllText("profile.json");


        static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			// Prepare URL for `PDF To TXT` API call
			string query = Uri.EscapeUriString(string.Format(
				"https://api.pdf.co/v1/pdf/convert/to/text?name={0}&password={1}&pages={2}&url={3}&profiles={4}", 
				Path.GetFileName(DestinationFile),
				Password,
				Pages,
				SourceFileUrl,
                Profiles));

			try
			{
				// Execute request
				string response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Get URL of generated TXT file
					string resultFileUrl = json["url"].ToString();

					// Download TXT file
					webClient.DownloadFile(resultFileUrl, DestinationFile);

					Console.WriteLine("Generated TXT file saved as \"{0}\" file.", DestinationFile);
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
