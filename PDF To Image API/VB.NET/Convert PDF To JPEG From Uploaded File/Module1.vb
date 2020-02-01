'*******************************************************************************************'
'                                                                                           '
' Download Free Evaluation Version From:     https://bytescout.com/download/web-installer   '
'                                                                                           '
' Also available as Web API! Get free API Key https://app.pdf.co/signup                     '
'                                                                                           '
' Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                '
' https://www.bytescout.com                                                                 '
' https://www.pdf.co                                                                        '
'*******************************************************************************************'


Imports System.IO
Imports System.Net
Imports Newtonsoft.Json.Linq

Module Module1

	' The authentication key (API Key).
	' Get your own by registering at https://app.pdf.co/documentation/api
	Const API_KEY As String = "***********************************"

	' Source PDF file
	const SourceFile as String = ".\sample.pdf"
	' Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
	const Pages as String = ""
	' PDF document password. Leave empty for unprotected documents.
	const Password as String = ""
	
	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		' 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
		' * If you already have the direct file URL, skip to the step 3.

		' Prepare URL for `Get Presigned URL` API call
		Dim query As string = Uri.EscapeUriString(string.Format(
			"https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name={0}", 
			Path.GetFileName(SourceFile)))

		Try
			' Execute request
			Dim response As string = webClient.DownloadString(query)

			' Parse JSON response
			Dim json As JObject = JObject.Parse(response)

			If json("error").ToObject(Of Boolean) = False Then

				' Get URL to use for the file upload
				Dim uploadUrl As string = json("presignedUrl").ToString()
				' Get URL of uploaded file to use with later API calls
				Dim uploadedFileUrl As string = json("url").ToString()

				' 2. UPLOAD THE FILE TO CLOUD.

				webClient.Headers.Add("content-type", "application/octet-stream")
				webClient.UploadFile(uploadUrl, "PUT", SourceFile) ' You can use UploadData() instead if your file is byte array or Stream
				
				' 3. CONVERT UPLOADED PDF FILE TO JPEG

				' Prepare URL for `PDF To JPEG` API call
				query = Uri.EscapeUriString(String.Format(
					"https://api.pdf.co/v1/pdf/convert/to/jpg?password={0}&pages={1}&url={2}",
					Password,
					Pages,
					uploadedFileUrl))

				' Execute request
				response = webClient.DownloadString(query)

				' Parse JSON response
				json = JObject.Parse(response)

				If json("error").ToObject(Of Boolean) = False Then
				
					' Download generated JPEG files
					Dim page As Integer = 1
					For Each token As JToken In json("urls")
					
						Dim resultFileUrl As string = token.ToString()
						Dim localFileName As String = String.Format(".\page{0}.jpg", page)

						webClient.DownloadFile(resultFileUrl, localFileName)

						Console.WriteLine("Downloaded ""{0}"".", localFileName)
						page = page + 1

					Next

				Else 
					Console.WriteLine(json("message").ToString())
				End If

			End If
			
		Catch ex As WebException
			Console.WriteLine(ex.ToString())
		End Try

		webClient.Dispose()


		Console.WriteLine()
		Console.WriteLine("Press any key...")
		Console.ReadKey()

	End Sub

End Module
