//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
//                                                                                           //
//*******************************************************************************************//


using System;
using RestSharp;

namespace HelloWorldApplication {

		class HelloWorld {

				static void Main(string[] args) {

						var client = new RestClient("https://api.pdf.co/v1/pdf/convert/from/email");
						client.Timeout = -1;

						var request = new RestRequest(Method.POST);
						request.AddHeader("Content-Type", "application/json");
						request.AddHeader("x-api-key", "{{x-api-key}}");

				        // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
						request.AddParameter("application/json", "{\n    \"url\": \"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml\",\n    \"embedAttachments\": true,\n    \"name\": \"email-with-attachments\",\n    \"async\": false,\n    \"encrypt\": false,\n    \"profiles\": \"{\\\"orientation\\\": \\\"landscape\\\", \\\"paperSize\\\": \\\"letter\\\" }\"\n}",  ParameterType.RequestBody);

						IRestResponse response = client.Execute(request);

						Console.WriteLine(response.Content);
				}

		}

}
