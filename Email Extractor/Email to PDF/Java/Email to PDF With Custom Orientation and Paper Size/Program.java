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


import java.io.*;
import okhttp3.*;
public class main {

		public static void main(String []args) throws IOException{

				OkHttpClient client = new OkHttpClient().newBuilder()
						.build();

				MediaType mediaType = MediaType.parse("application/json");

			    // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
				RequestBody body = RequestBody.create(mediaType, "{\n    \"url\": \"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml\",\n    \"embedAttachments\": true,\n    \"name\": \"email-with-attachments\",\n    \"async\": false,\n    \"encrypt\": false,\n    \"profiles\": \"{\\\"orientation\\\": \\\"landscape\\\", \\\"paperSize\\\": \\\"letter\\\" }\"\n}");

				Request request = new Request.Builder()
						.url("https://api.pdf.co/v1/pdf/convert/from/email")
						.method("POST", body)
						.addHeader("Content-Type", "application/json")
						.addHeader("x-api-key", "{{x-api-key}}")
						.build();

				Response response = client.newCall(request).execute();

				System.out.println(response.body().string());
		}

}
