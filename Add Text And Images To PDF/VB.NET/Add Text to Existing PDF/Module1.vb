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
    Const SourceFileUrl As String = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

    ' Comma-separated list of page indices (Or ranges) to process. Leave empty for all pages. Example '0,2-5,7-'.
    Const Pages As String = ""

    ' PDF document password. Leave empty for unprotected documents.
    Const Password As String = ""

    ' Destination PDF file name
    Const DestinationFile As String = ".\result.pdf"

    ' Text annotation params
    Private Const Type2 As String = "annotation"
    Private Const X2 As Int32 = 400
    Private Const Y2 As Int32 = 600
    Private Const Text As String = "APPROVED"
    Private Const FontName As String = "Times New Roman"
    Private Const FontSize As Decimal = 24
    Private Const Color As String = "FF0000"

    Sub Main()

        ' Create standard .NET web client instance
        Dim webClient As WebClient = New WebClient()

        ' Set API Key
        webClient.Headers.Add("x-api-key", API_KEY)

        ' * Add text annotation *
        ' Prepare URL for `PDF Edit` API call
        Dim query As String = Uri.EscapeUriString(String.Format(
            "https://api.pdf.co/v1/pdf/edit/add?name={0}&password={1}&pages={2}&url={3}&type={4}&x={5}&y={6}&text={7}&fontname={8}&size={9}&color={10}",
                Path.GetFileName(DestinationFile),
                Password,
                Pages,
                SourceFileUrl,
                Type2,
                X2,
                Y2,
                Text,
                FontName,
                FontSize,
                Color))

        Try
            ' Execute request
            Dim response As String = webClient.DownloadString(query)

            ' Parse JSON response
            Dim json As JObject = JObject.Parse(response)

            If json("error").ToObject(Of Boolean) = False Then

                ' Get URL of generated PDF file
                Dim resultFileUrl As String = json("url").ToString()

                ' Download PDF file
                webClient.DownloadFile(resultFileUrl, DestinationFile)

                Console.WriteLine("Generated PDF file saved as ""{0}"" file.", DestinationFile)

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
