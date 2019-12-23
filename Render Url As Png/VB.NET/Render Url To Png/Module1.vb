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

	' Input url file
	Const InputUrl as String = "https://www.wikipedia.org"

	' Result file name
	Const ResultFileName As String = ".\result.png"


	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		' Prepare URL for `Urlto Png` API call
		Dim query As String = Uri.EscapeUriString(string.Format(
			"https://api.pdf.co/v1/url/convert/to/png?name={0}&url={1}", 
			Path.GetFileName(ResultFileName), 
			InputUrl))

		Try
			' Execute request
			Dim response As String = webClient.DownloadString(query)

			' Parse JSON response
			Dim json As JObject = JObject.Parse(response)

			If json("error").ToObject(Of Boolean) = False Then
				
				' Get URL of Generated output image file
				Dim resultFileURI As string = json("url").ToString()

				' Download the image file
				webClient.DownloadFile(resultFileURI, ResultFileName)

				Console.WriteLine("Generated output saved to ""{0}"" file.", ResultFileName)

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
