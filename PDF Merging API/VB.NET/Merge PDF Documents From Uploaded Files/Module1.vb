'*******************************************************************************************'
'                                                                                           '
' Download Free Evaluation Version From:     https://bytescout.com/download/web-installer   '
'                                                                                           '
' Also available as Web API! Free Trial Sign Up: https://secure.bytescout.com/users/sign_up '
'                                                                                           '
' Copyright © 2017-2018 ByteScout Inc. All rights reserved.                                 '
' http://www.bytescout.com                                                                  '
'                                                                                           '
'*******************************************************************************************'


Imports System.IO
Imports System.Net
Imports Newtonsoft.Json.Linq

Module Module1

	' The authentication key (API Key).
	' Get your own by registering at https://app.pdf.co/documentation/api
	Const API_KEY As String = "***********************************"

	' Source PDF files
	Dim SourceFiles as String() = { ".\sample1.pdf", ".\sample2.pdf" }
	' Destination PDF file name
	const DestinationFile as string = ".\result.pdf"

	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		' 1. UPLOAD FILES TO CLOUD

		Dim uploadedFiles As List(Of String) = New List(Of String)()

		Try

			For Each pdfFile As String In SourceFiles

				' 1a. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.

				' Prepare URL for `Get Presigned URL` API call
				Dim query As string = Uri.EscapeUriString(string.Format(
					"https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name={0}",
					Path.GetFileName(pdfFile)))

				' Execute request
				Dim response As string = webClient.DownloadString(query)

				' Parse JSON response
				Dim json As JObject = JObject.Parse(response)

				If json("error").ToObject(Of Boolean) = False Then

					' Get URL to use for the file upload
					Dim uploadUrl As string = json("presignedUrl").ToString()
					' Get URL of uploaded file to use with later API calls
					Dim uploadedFileUrl As string = json("url").ToString()

					' 1b. UPLOAD THE FILE TO CLOUD.

					webClient.Headers.Add("content-type", "application/octet-stream")
					webClient.UploadFile(uploadUrl, "PUT", pdfFile) ' You can use UploadData() instead if your file is byte array or Stream

					uploadedFiles.Add(uploadedFileUrl)

				Else 
					Console.WriteLine(json("message").ToString())
				End If
				
			Next

			if uploadedFiles.Count > 0 Then

				' 2. MERGE UPLOADED PDF DOCUMENTS

				' Prepare URL for `Merge PDF` API call
				Dim query As String = Uri.EscapeUriString(String.Format(
					"https://api.pdf.co/v1/pdf/merge?name={0}&url={1}",
					Path.GetFileName(DestinationFile),
					string.Join(",", uploadedFiles)))

				' Execute request
				Dim response As String = webClient.DownloadString(query)

				' Parse JSON response
				Dim json As JObject = JObject.Parse(response)

				If json("error").ToObject(Of Boolean) = False Then
				
					' Get URL of generated PDF file
					Dim resultFileUrl As string = json("url").ToString()

					' Download PDF file
					webClient.DownloadFile(resultFileUrl, DestinationFile)

					Console.WriteLine("Generated PDF file saved as ""{0}"" file.", DestinationFile)

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
