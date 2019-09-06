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
using System.Collections.Specialized;
using System.IO;
using System.Net;
using System.Text;
using Newtonsoft.Json.Linq;

namespace ByteScoutWebApiExample
{
	class Program
	{
		// The authentication key (API Key).
		// Get your own by registering at https://app.pdf.co/documentation/api
		const String API_KEY = "***********************************";
		
		// Source PDF file
		const string SourceFile = @".\MultiPageTable.pdf";
		// PDF document password. Leave empty for unprotected documents.
		const string Password = "";
		// Destination TXT file name
		const string DestinationFile = @".\result.json";

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
					string uploadedFileUrl = json["url"].ToString();

					// 2. UPLOAD THE FILE TO CLOUD.

					webClient.Headers.Add("content-type", "application/octet-stream");
					webClient.UploadFile(uploadUrl, "PUT", SourceFile); // You can use UploadData() instead if your file is byte[] or Stream
					webClient.Headers.Remove("content-type");

					// 3. PARSE UPLOADED PDF DOCUMENT

					// URL for `Document Parser` API call
					query = "https://api.pdf.co/v1/pdf/documentparser";

                    NameValueCollection requestBody = new NameValueCollection();
                    requestBody.Add("url", uploadedFileUrl);
                    requestBody.Add("template", templateText);

                    // Execute request
                    byte[] responseBytes = webClient.UploadValues(query, "POST", requestBody);
                    response = Encoding.UTF8.GetString(responseBytes);

                    // Parse response
					json = JObject.Parse(response);

					if (json["error"].ToObject<bool>() == false)
					{
						// Get URL of generated JSON file
						string resultFileUrl = json["url"].ToString();

						// Download JSON file
						webClient.DownloadFile(resultFileUrl, DestinationFile);

						Console.WriteLine("Generated JSON file saved as \"{0}\" file.", DestinationFile);
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

			webClient.Dispose();


			Console.WriteLine();
			Console.WriteLine("Press any key...");
			Console.ReadKey();
		}
	}
}