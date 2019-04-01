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

    ' Direct URL of source file to search barcodes in.
    Const SourceFileURL As String = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/barcode-reader/sample.pdf"
    ' Comma-separated list of barcode types to search. 
    ' See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/read_from_url.html
    Const Pages As String = ""

    ' Sample profile that sets advanced conversion options
    ' Advanced options are properties of Reader class from Bytescout BarCodeReader used in the back-end:
    ' https//cdn.bytescout.com/help/BytescoutBarCodeReaderSDK/html/ba101d21-3db7-eb54-d112-39cadc023d02.htm
    ReadOnly Profiles = File.ReadAllText("profile.json")

    Sub Main()

        ' Create standard .NET web client instance
        Dim webClient As WebClient = New WebClient()

        ' Set API Key
        webClient.Headers.Add("x-api-key", API_KEY)

        ' Prepare URL for `Barcode Reader` API call
        Dim query As String = Uri.EscapeUriString(String.Format(
            "https://api.pdf.co/v1/barcode/read/from/url?pages={0}&url={1}&profiles={2}",
            Pages,
            SourceFileURL,
            Profiles))

        Try
            ' Execute request
            Dim response As String = webClient.DownloadString(query)

            ' Parse JSON response
            Dim json As JObject = JObject.Parse(response)

            If json("error").ToObject(Of Boolean) = False Then

                ' Display found barcodes in console
                For Each token As JToken In json("barcodes")
                    Console.WriteLine("Found barcode:")
                    Console.WriteLine("  Type: " + token("TypeName").ToString())
                    Console.WriteLine("  Value: " + token("Value").ToString())
                    Console.WriteLine("  Document Page Index: " + token("Page").ToString())
                    Console.WriteLine("  Rectangle: " + token("Rect").ToString())
                    Console.WriteLine("  Confidence: " + token("Confidence").ToString())
                    Console.WriteLine()
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
