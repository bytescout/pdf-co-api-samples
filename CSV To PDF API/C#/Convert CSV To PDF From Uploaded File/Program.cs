//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Free Trial Sign Up: https://secure.bytescout.com/users/sign_up //
//                                                                                           //
// Copyright © 2017-2018 ByteScout Inc. All rights reserved.                                 //
// http://www.bytescout.com                                                                  //
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
		
		// Source CSV file
		const string SourceFile = @".\sample.csv";
		// Destination PDF file name
		const string DestinationFile = @".\result.pdf";

		static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			// 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
			// * If you already have a direct file URL, skip to the step 3.
			
			// Prepare URL for `Get Presigned URL` API call
			string query = Uri.EscapeUriString(string.Format(
				"https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name={0}", 
				Path.GetFileName(SourceFile)));

			try
			{
				// Execute request
				string response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Get URL to use for the file upload
					string uploadUrl = json["presignedUrl"].ToString();
					// Get URL of uploaded file to use with later API calls
					string uploadedFileUrl = json["url"].ToString();

					// 2. UPLOAD THE FILE TO CLOUD.

					webClient.Headers.Add("content-type", "application/octet-stream");
					webClient.UploadFile(uploadUrl, "PUT", SourceFile); // You can use UploadData() instead if your file is byte[] or Stream

					// 3. CONVERT UPLOADED CSV FILE TO PDF

					// Prepare URL for `CSV To PDF` API call
					query = Uri.EscapeUriString(string.Format(
						"https://api.pdf.co/v1/pdf/convert/from/csv?name={0}&url={1}",
						Path.GetFileName(DestinationFile),
						uploadedFileUrl));

					// Execute request
					response = webClient.DownloadString(query);

					// Parse JSON response
					json = JObject.Parse(response);

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
				else
				{
					Console.WriteLine(json["message"].ToString());
				}
			}
			catch (WebException e)
			{
				Console.WriteLine(e.ToString());
			}

			webClient.Dispose()


			Console.WriteLine();
			Console.WriteLine("Press any key...");
			Console.ReadKey();
		}
	}
}
