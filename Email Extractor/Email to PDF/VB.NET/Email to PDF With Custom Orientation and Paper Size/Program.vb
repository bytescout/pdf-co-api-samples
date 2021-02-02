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


Imports System
Imports RestSharp

Namespace HelloWorldApplication

    Class HelloWorld

        Private Shared Sub Main(ByVal args As String())

            Dim client = New RestClient("https://api.pdf.co/v1/pdf/convert/from/email")
            client.Timeout = -1

            Dim request = New RestRequest(Method.POST)
            request.AddHeader("Content-Type", "application/json")
            request.AddHeader("x-api-key", "{{x-api-key}}")

            request.AddParameter("application/json", "{" & vbLf & "    ""url"": ""https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml""," & vbLf & "    ""embedAttachments"": true," & vbLf & "    ""name"": ""email-with-attachments""," & vbLf & "    ""async"": false," & vbLf & "    ""encrypt"": false," & vbLf & "    ""profiles"": ""{\""orientation\"": \""landscape\"", \""paperSize\"": \""letter\"" }""" & vbLf & "}", ParameterType.RequestBody)

            Dim response As IRestResponse = client.Execute(request)

            Console.WriteLine(response.Content)

        End Sub

    End Class

End Namespace
