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
using System.Threading;


// Cloud API asynchronous "PDF To HTML" job example.
// Allows to avoid timeout errors when processing huge or scanned PDF documents.

namespace ByteScoutWebApiExample
{
	class Program
	{
		// The authentication key (API Key).
		// Get your own by registering at https://app.pdf.co/documentation/api
		const String API_KEY = "***********************************";

		// Direct URL of source PDF file.
		const string SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-html/sample.pdf";
		// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
		const string Pages = "";
		// PDF document password. Leave empty for unprotected documents.
		const string Password = "";
		// Destination HTML file name
		const string DestinationFile = @".\result.html";
		// Set to `true` to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
		const bool PlainHtml = false;
		// Set to `true` if your document has the column layout like a newspaper.
		const bool ColumnLayout = false;
		// (!) Make asynchronous job
		const bool Async = true;


		static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			try
			{
				// Prepare URL for `PDF To HTML` API call
				String query = Uri.EscapeUriString(string.Format(
					"https://api.pdf.co/v1/pdf/convert/to/html?name={0}&password={1}&pages={2}&simple={3}&columns={4}&url={5}&async={6}",
					Path.GetFileName(DestinationFile),
					Password,
					Pages,
					PlainHtml,
					ColumnLayout,
					SourceFileUrl,
					Async));

				// Execute request
				String response = webClient.DownloadString(query);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Asynchronous job ID
					string jobId = json["jobId"].ToString();
					// URL of generated HTML file that will available after the job completion
					string resultFileUrl = json["url"].ToString();

					// Check the job status in a loop. 
					// If you don't want to pause the main thread you can rework the code 
					// to use a separate thread for the status checking and completion.
					do
					{
						string status = CheckJobStatus(jobId); // Possible statuses: "working", "failed", "aborted", "success".

						// Display timestamp and status (for demo purposes)
						Console.WriteLine(DateTime.Now.ToLongTimeString() + ": " + status);

						if (status == "success")
						{
							// Download HTML file
							webClient.DownloadFile(resultFileUrl, DestinationFile);

							Console.WriteLine("Generated HTML file saved as \"{0}\" file.", DestinationFile);
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

		static string CheckJobStatus(string jobId)
		{
			using (WebClient webClient = new WebClient())
			{
				// Set API Key
                webClient.Headers.Add("x-api-key", API_KEY);
				
				string url = "https://api.pdf.co/v1/job/check?jobid=" + jobId;

				string response = webClient.DownloadString(url);
				JObject json = JObject.Parse(response);

				return Convert.ToString(json["status"]);
			}
		}
	}
}
