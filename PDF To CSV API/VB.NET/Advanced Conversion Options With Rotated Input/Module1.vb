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
    Const API_KEY As String = "******************************"

    ' Source PDF file
    Const SourceFile As String = ".\sample-rotated.pdf"
    ' Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
    Const Pages As String = ""
    ' PDF document password. Leave empty for unprotected documents.
    Const Password As String = ""
    ' Destination CSV file name
    Const DestinationFile As String = ".\result.csv"

    ' Sample profile that sets advanced conversion options.
    ' Advanced options are properties of CSVExtractor class from ByteScout PDF Extractor SDK used in the back-end:
    ' https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/87ce5fa6-3143-167d-abbd-bc7b5e160fe5.htm

    'Valid RotationAngle values
    '0 - no rotation
    '1 - 90 degrees
    '2 - 180 degrees
    '3 - 270 degrees
    ReadOnly Profiles As String = File.ReadAllText("profile.json")

    Sub Main()

        ' Create standard .NET web client instance
        Dim webClient As WebClient = New WebClient()

        ' Set API Key
        webClient.Headers.Add("x-api-key", API_KEY)

        ' 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
        ' * If you already have a direct file URL, skip to the step 3.

        ' Prepare URL for `Get Presigned URL` API call
        Dim query As String = Uri.EscapeUriString(String.Format(
            "https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name={0}",
            Path.GetFileName(SourceFile)))

        Try
            ' Execute request
            Dim response As String = webClient.DownloadString(query)

            ' Parse JSON response
            Dim json As JObject = JObject.Parse(response)

            If json("error").ToObject(Of Boolean) = False Then
                ' Get URL to use for the file upload
                Dim uploadUrl As String = json("presignedUrl").ToString()
                ' Get URL of uploaded file to use with later API calls
                Dim uploadedFileUrl As String = json("url").ToString()

                ' 2. UPLOAD THE FILE TO CLOUD.

                webClient.Headers.Add("content-type", "application/octet-stream")
                webClient.UploadFile(uploadUrl, "PUT", SourceFile) ' You can use UploadData() instead if your file is byte array or Stream

                ' 3. CONVERT UPLOADED PDF FILE TO CSV

                ' Prepare URL for `PDF To CSV` API call
                query = Uri.EscapeUriString(String.Format(
                    "https://api.pdf.co/v1/pdf/convert/to/csv?name={0}&password={1}&pages={2}&url={3}&profiles={4}",
                    Path.GetFileName(DestinationFile),
                    Password,
                    Pages,
                    uploadedFileUrl,
                    Profiles))

                ' Execute request
                response = webClient.DownloadString(query)

                ' Parse JSON response
                json = JObject.Parse(response)

                If json("error").ToObject(Of Boolean) = False Then

                    ' Get URL of generated CSV file
                    Dim resultFileUrl As String = json("url").ToString()

                    ' Download CSV file
                    webClient.DownloadFile(resultFileUrl, DestinationFile)

                    Console.WriteLine("Generated CSV file saved as ""{0}"" file.", DestinationFile)

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
