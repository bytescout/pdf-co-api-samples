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

        // Direct URL of source file (image or PDF) to search barcodes in.
        const string SourceFileURL = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf";

		// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
		const string Pages = "";

        // Sample profile that sets advanced conversion options
        //  Advanced options are properties of Reader class from Bytescout BarCodeReader used in the back-end:
        // https://cdn.bytescout.com/help/BytescoutBarCodeReaderSDK/html/ba101d21-3db7-eb54-d112-39cadc023d02.htm
        static string Profiles = File.ReadAllText("profile.json");

        static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			// Prepare URL for `Barcode Reader` API call
			string query = Uri.EscapeUriString(string.Format("https://api.pdf.co/v1/barcode/read/from/url?pages={0}&url={1}&profiles={2}", 
				Pages,
				SourceFileURL,
                Profiles));

			try
			{
				// Execute request
				string response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Display found barcodes in console
					foreach (JToken token in json["barcodes"])
					{
						Console.WriteLine("Found barcode:");
						Console.WriteLine("  Type: " + token["TypeName"]);
						Console.WriteLine("  Value: " + token["Value"]);
						Console.WriteLine("  Document Page Index: " + token["Page"]);
						Console.WriteLine("  Rectangle: " + token["Rect"]);
						Console.WriteLine("  Confidence: " + token["Confidence"]);
						Console.WriteLine();
					}
				}
				else
				{
					// Display service reported error
					Console.WriteLine(json["message"].ToString());
				}
			}
			catch (WebException e)
			{
				// Display request error
				Console.WriteLine(e.ToString());
			}

			webClient.Dispose();


			Console.WriteLine();
			Console.WriteLine("Press any key...");
			Console.ReadKey();
		}
	}
}
