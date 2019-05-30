'*******************************************************************************************'
'                                                                                           '
' Download Free Evaluation Version From:     https://bytescout.com/download/web-installer   '
'                                                                                           '
' Also available as Web API! Get free API Key https://app.pdf.co/signup                     '
'                                                                                           '
' Copyright © 2017-2019 ByteScout, Inc. All rights reserved.                                '
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

	' Direct URL of source PDF file.
	Const SourceFileUrl As String = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-html/sample.pdf"
	' Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
	const Pages as String = ""
	' PDF document password. Leave empty for unprotected documents.
	const Password As String = ""
	' Destination HTML file name
	const DestinationFile as String = ".\result.html"
	' Set to `true` to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
	const PlainHtml as Boolean = False
	' Set to `true` if your document has the column layout like a newspaper.
	const ColumnLayout as Boolean = False

	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		' Prepare URL for `PDF To HTML` API call
		Dim query As String = Uri.EscapeUriString(String.Format(
			"https://api.pdf.co/v1/pdf/convert/to/html?name={0}&password={1}&pages={2}&simple={3}&columns={4}&url={5}",
			Path.GetFileName(DestinationFile),
			Password,
			Pages,
			PlainHtml,
			ColumnLayout,
			SourceFileUrl))

		Try
			' Execute request
			Dim response As String = webClient.DownloadString(query)

			' Parse JSON response
			Dim json As JObject = JObject.Parse(response)

			If json("error").ToObject(Of Boolean) = False Then

				' Get URL of generated HTML file
				Dim resultFileUrl As String = json("url").ToString()

				' Download HTML file
				webClient.DownloadFile(resultFileUrl, DestinationFile)

				Console.WriteLine("Generated HTML file saved as ""{0}"" file.", DestinationFile)

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
