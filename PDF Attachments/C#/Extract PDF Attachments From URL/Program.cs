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
using RestSharp;
namespace HelloWorldApplication {
		class HelloWorld {
				static void Main(string[] args) {
						var client = new RestClient("https://api.pdf.co/v1/pdf/attachments/extract");
						client.Timeout = -1;
						var request = new RestRequest(Method.POST);
						request.AddHeader("Content-Type", "application/json");
						request.AddHeader("x-api-key", "__Replace_With_Your_PDFco_API_Key__");
						var body = @"{" + "\n" +
						@"    ""url"": ""https://bytescout-com.s3.us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-attachments/attachments.pdf""," + "\n" +
						@"    ""inline"": true," + "\n" +
						@"    ""async"": false" + "\n" +
						@"}";
						request.AddParameter("application/json", body,  ParameterType.RequestBody);
						IRestResponse response = client.Execute(request);
						Console.WriteLine(response.Content);
				}
		}
}
