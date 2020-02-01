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

	' Result file name
	Const ResultFileName As String = ".\barcode.png"
	' Barcode type. See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/generate.html
	Const BarcodeType As String = "Code128"
	' Barcode value
	Const BarcodeValue As String = "qweasd123456"

	Sub Main()

		' Create standard .NET web client instance
		Dim webClient As WebClient = New WebClient()

		' Set API Key
		webClient.Headers.Add("x-api-key", API_KEY)

		' Prepare URL for `Barcode Generator` API call
		Dim query As String = Uri.EscapeUriString(string.Format(
			"https://api.pdf.co/v1/barcode/generate?name={0}&type={1}&value={2}", 
			Path.GetFileName(ResultFileName), 
			BarcodeType, 
			BarcodeValue))

		Try
			' Execute request
			Dim response As String = webClient.DownloadString(query)

			' Parse JSON response
			Dim json As JObject = JObject.Parse(response)

			If json("error").ToObject(Of Boolean) = False Then
				
				' Get URL of generated barcode image file
				Dim resultFileURI As string = json("url").ToString()

				' Download the image file
				webClient.DownloadFile(resultFileURI, ResultFileName)

				Console.WriteLine("Generated barcode saved to ""{0}"" file.", ResultFileName)

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
