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
		const String API_KEY = "***********************************";

		// Encoded Source PDF file. This PDF is Encrypted with AES128 algorithm.
		// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
		const string SourceFileUrl = @"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/encryption/sample_encrypted_aes128.pdf";

		// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
		const string Pages = "";

		// Refer to documentations for more info. https://apidocs.pdf.co/32-1-user-controlled-data-encryption-and-decryption
		const string Profiles = "{ 'DataDecryptionAlgorithm': 'AES128', 'DataDecryptionKey': 'HelloThisKey1234', 'DataDecryptionIV': 'TreloThisKey1234' }";
		
		static void Main(string[] args)
		{
			// Create standard .NET web client instance
			WebClient webClient = new WebClient();

			// Set API Key
			webClient.Headers.Add("x-api-key", API_KEY);

			try
			{
				// URL for `PDF To JPEG` API call
				string url = "https://api.pdf.co/v1/pdf/convert/to/jpg";

				// Prepare requests params as JSON
				Dictionary<string, object> parameters = new Dictionary<string, object>();
				parameters.Add("url", SourceFileUrl);
				parameters.Add("pages", Pages);
				parameters.Add("profiles", Profiles);

				// Convert dictionary of params to JSON
				string jsonPayload = JsonConvert.SerializeObject(parameters);

				// Execute POST request with JSON payload
				string response = webClient.UploadString(url, jsonPayload);

				// Parse JSON response
				JObject json = JObject.Parse(response);

				if (json["error"].ToObject<bool>() == false)
				{
					// Download generated JPEG files
					int page = 1;
					foreach (JToken token in json["urls"])
					{
						string resultFileUrl = token.ToString();
						string localFileName = String.Format(@".\page{0}.jpg", page);

						webClient.DownloadFile(resultFileUrl, localFileName);

						Console.WriteLine("Downloaded \"{0}\".", localFileName);
						page++;
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
