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
        const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf";
		// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
		const string Pages = "";
		// PDF document password. Leave empty for unprotected documents.
		const string Password = "";

        // Destination PDF file name
		const string DestinationFile = @".\result.pdf";

        // Text annotation params
        private const string Type2 = "annotation";
        private const int X2 = 400;
        private const int Y2 = 600;
        private const string Text = "APPROVED";
        private const string FontName = "Times New Roman";
        private const float FontSize = 24;
        private const string Color = "FF0000";


		static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

            // * Add text annotation *

			// Prepare URL for `PDF Edit` API call
			string query = Uri.EscapeUriString(string.Format(
				"https://api.pdf.co/v1/pdf/edit/add?name={0}&password={1}&pages={2}&url={3}&type={4}&x={5}&y={6}&text={7}&fontname={8}&size={9}&color={10}",
				Path.GetFileName(DestinationFile),
				Password,
				Pages,
				SourceFileUrl,
                Type2,
                X2,
                Y2,
                Text,
                FontName,
                FontSize,
                Color));

			try
			{
				// Execute request
				string response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Get URL of generated PDF file
					string resultFileUrl = json["url"].ToString();

					// Download PDF file
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
