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

    ' Direct URL of source PDF file.
    Const SourceFileUrl As String = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf"
	' Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
	const Pages as String = ""
	' PDF document password. Leave empty for unprotected documents.
	const Password As string = ""
	' Destination JSON file name
	const DestinationFile as string = ".\result.json"

    ' Some of advanced options available through profiles:
    ' (it can be single/double-quoted and contain comments.)
    ' {
    ' 	"profiles": [
    ' 		{
    ' 			"profile1": {
    ' 				"SaveImages": "None", // Whether to extract images. Values: "None", "Embed".
    ' 				"ImageFormat": "PNG", // Image format for extracted images. Values: "PNG", "JPEG", "GIF", "BMP".
    ' 				"SaveVectors": false, // Whether to extract vector objects (vertical and horizontal lines). Values: true / false
    ' 				"ExtractInvisibleText": true, // Invisible text extraction. Values: true / false
    ' 				"ExtractShadowLikeText": true, // Shadow-like text extraction. Values: true / false
    ' 				"LineGroupingMode": "None", // Values: "None", "GroupByRows", "GroupByColumns", "JoinOrphanedRows"
    ' 				"ColumnDetectionMode": "ContentGroupsAndBorders", // Values: "ContentGroupsAndBorders", "ContentGroups", "Borders", "BorderedTables"
    ' 				"Unwrap": false, // Unwrap grouped text in table cells. Values: true / false
    ' 				"ShrinkMultipleSpaces": false, // Shrink multiple spaces in table cells that affect column detection. Values: true / false
    ' 				"DetectNewColumnBySpacesRatio": 1, // Spacing ratio that affects column detection.
    ' 				"CustomExtractionColumns": [ 0, 50, 150, 200, 250, 300 ], // Explicitly specify columns coordinates for table extraction.
    ' 				"CheckPermissions": true, // Ignore document permissions. Values: true / false
    ' 			}
    ' 		}
    ' 	]
    ' }

    ' Sample profile that sets advanced conversion options
    ' Advanced options are properties of JSONExtractor class from ByteScout JSON Extractor SDK used in the back-end:
    ' https//cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/84356d44-6249-3251-2da8-83c1f34a2f39.htm
    ReadOnly Profiles = File.ReadAllText("profile.json")

    Sub Main()

        ' Create standard .NET web client instance
        Dim webClient As WebClient = New WebClient()

        ' Set API Key
        webClient.Headers.Add("x-api-key", API_KEY)

        ' Prepare URL for `PDF To JSON` API call
        Dim query As String = Uri.EscapeUriString(String.Format(
            "https://api.pdf.co/v1/pdf/convert/to/json?name={0}&password={1}&pages={2}&url={3}&profiles={4}",
            Path.GetFileName(DestinationFile),
            Password,
            Pages,
            SourceFileUrl,
            Profiles))

        Try
            ' Execute request
            Dim response As String = webClient.DownloadString(query)

            ' Parse JSON response
            Dim json As JObject = JObject.Parse(response)

            If json("error").ToObject(Of Boolean) = False Then

                ' Get URL of generated JSON file
                Dim resultFileUrl As String = json("url").ToString()

                ' Download JSON file
                webClient.DownloadFile(resultFileUrl, DestinationFile)

                Console.WriteLine("Generated JSON file saved as ""{0}"" file.", DestinationFile)

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
