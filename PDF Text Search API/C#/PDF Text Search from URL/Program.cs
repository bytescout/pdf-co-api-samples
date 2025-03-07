//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
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
		// Get your own by registering at https://app.pdf.co
		const String API_KEY = "*****************************************";
		
		// Direct URL of source PDF file.
        // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
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

            // URL for PDF text search API call.
            // See documentation: https://apidocs.pdf.co
            string url = "https://api.pdf.co/v1/pdf/find";

			// Prepare requests params as JSON
			Dictionary<string, object> parameters = new Dictionary<string, object>();
			parameters.Add("password", Password);
			parameters.Add("pages", Pages);
			parameters.Add("url", SourceFileUrl);
			parameters.Add("searchString", SearchString);
			parameters.Add("regexSearch", RegexSearch);

			// Convert dictionary of params to JSON
			string jsonPayload = JsonConvert.SerializeObject(parameters);

			try
			{
				// Execute POST request with JSON payload
				string response = webClient.UploadString(url, jsonPayload);

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
