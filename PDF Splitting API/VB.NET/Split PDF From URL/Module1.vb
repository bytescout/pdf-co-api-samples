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

	' Source PDF file to split
	Const SourceFileUrl As String = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/pdf-split/sample.pdf"
	' Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
	const Pages as String = "1-2,3-"
	
	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		' Prepare URL for `Split PDF` API call
		Dim query As String = Uri.EscapeUriString(String.Format(
			"https://api.pdf.co/v1/pdf/split?pages={0}&url={1}",
			Pages,
			SourceFileUrl))

		Try
			' Execute request
			Dim response As String = webClient.DownloadString(query)

			' Parse JSON response
			Dim json As JObject = JObject.Parse(response)

			If json("error").ToObject(Of Boolean) = False Then

				' Download generated PDF files
				Dim part As Integer = 1
				For Each token As JToken In json("urls")
					
					Dim resultFileUrl As string = token.ToString()
					Dim localFileName As String = String.Format(".\part{0}.pdf", part)

					webClient.DownloadFile(resultFileUrl, localFileName)

					Console.WriteLine("Downloaded ""{0}"".", localFileName)
					part = part + 1

				Next

			Else
				Console.WriteLine(json("message").ToString())
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
