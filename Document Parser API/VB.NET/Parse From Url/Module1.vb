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


Imports System.Collections.Specialized
Imports System.IO
Imports System.Net
Imports System.Text
Imports Newtonsoft.Json.Linq

Module Module1

    ' The authentication key (API Key).
    ' Get your own by registering at https://app.pdf.co/documentation/api
    Const API_KEY As String = "***********************************"

    ' Source PDF file Urll
    Const SourceFileUrl As String = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/document-parser/MultiPageTable.pdf"

    ' Destination TXT file name
    Const DestinationFile As String = ".\result.json"

    Sub Main()

        ' Template text. Use Document Parser SDK (https//bytescout.com/products/developer/documentparsersdk/index.html)
        ' to create templates.
        ' Read template from file
        Dim templateText As String = File.ReadAllText("MultiPageTable-template1.yml")

        ' Create standard .NET web client instance
        Dim webClient As WebClient = New WebClient()

        ' Set API Key
        webClient.Headers.Add("x-api-key", API_KEY)

        Try

            ' PARSE UPLOADED PDF DOCUMENT

            ' URL for `Document Parser` API call
            Dim query As String = "https://api.pdf.co/v1/pdf/documentparser"

            Dim requestBody As New NameValueCollection()
            requestBody.Add("url", SourceFileUrl)
            requestBody.Add("template", templateText)

            ' Execute request
            Dim responseBytes As Byte() = webClient.UploadValues(query, "POST", requestBody)
            Dim response As String = Encoding.UTF8.GetString(responseBytes)

            ' Parse JSON response
            Dim json As JObject = JObject.Parse(response)

            If json("error").ToObject(Of Boolean) = False Then

                ' Get URL of generated JSON file
                Dim resultFileUrl As String = json("url")

                ' Download JSON file
                webClient.DownloadFile(resultFileUrl, DestinationFile)

                Console.WriteLine("Generated JSON file saved as {0} file.", DestinationFile)
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
