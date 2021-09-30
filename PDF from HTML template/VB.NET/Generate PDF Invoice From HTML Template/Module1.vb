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
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq

Module Module1

	' The authentication key (API Key).
	' Get your own by registering at https://app.pdf.co
	Const API_KEY As String = "***********************************"

	' HTML template
	Dim template As String = File.ReadAllText(".\invoice_template.html")
	' Data to fill the template
	Dim templateData As String = File.ReadAllText(".\invoice_data.json")
	' Destination PDF file name
	Const DestinationFile As String = ".\result.pdf"

	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		Try
			' Prepare URL for HTML to PDF API call
			Dim request As String = Uri.EscapeUriString(String.Format(
				"https://api.pdf.co/v1/pdf/convert/from/html?name={0}",
				Path.GetFileName(DestinationFile)))

			' Prepare request body in JSON format
			Dim jsonObject As JObject = New JObject(
				New JProperty("html", template),
				New JProperty("templateData", templateData))

			webClient.Headers.Add("Content-Type", "application/json")

			' Execute request
			Dim response As String = webClient.UploadString(request, jsonObject.ToString())

			' Parse JSON response
			Dim json As JObject = JObject.Parse(response)

			If json("error").ToObject(Of Boolean) = False Then

				' Get URL of generated PDF file
				Dim resultFileUrl As String = json("url").ToString()

				webClient.Headers.Remove("Content-Type") ' remove the header required for only the previous request

				' Download the PDF file
				webClient.DownloadFile(resultFileUrl, DestinationFile)

				Console.WriteLine("Generated PDF document saved as ""{0}"" file.", DestinationFile)

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
