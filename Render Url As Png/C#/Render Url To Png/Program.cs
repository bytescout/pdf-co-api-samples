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
		
		// Input url file
		const string InputUrl = @"https://www.wikipedia.org";

		// Result file name
		const string ResultFileName = @".\result.png";


		static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			// Prepare URL for `Urlto Png` API call
			string query = Uri.EscapeUriString(string.Format(
				"https://api.pdf.co/v1/url/convert/to/png?name={0}&url={1}", 
				Path.GetFileName(ResultFileName), 
				InputUrl));

			try
			{
				// Execute request
				string response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Get URL of Generated output image file
					string resultFileURI = json["url"].ToString();
					
					// Download the image file
					webClient.DownloadFile(resultFileURI, ResultFileName);

					Console.WriteLine("Generated output saved to \"{0}\" file.", ResultFileName);
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
