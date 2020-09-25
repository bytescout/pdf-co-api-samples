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
		const String API_KEY = "***********************************";
		
		// Direct URL of PDF file to get information
		const string SourceFileURL = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf";
		
		static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			// URL for `PDF Info` API call
			string url = "https://api.pdf.co/v1/pdf/info";

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
					// Display PDF document information
					foreach (JToken token in json["info"])
					{
						JProperty property = (JProperty) token;
						Console.WriteLine("{0}: {1}", property.Name, property.Value);
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
