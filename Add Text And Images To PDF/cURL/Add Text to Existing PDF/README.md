## How to add text and images to PDF in cURL with PDF.co Web API

### Continuous learning is a crucial part of computer science and this tutorial shows how to add text and images to PDF in cURL

Source code documentation samples give simple and easy method to install a needed feature into your application. What is PDF.co Web API? It is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf. It can help you to add text and images to PDF in your cURL application.

The following code snippet for PDF.co Web API works best when you need to quickly add text and images to PDF in your cURL application.  Simply copy and paste in your cURL project or application you and then run your app! Check cURL sample code samples to see if they respond to your needs and requirements for the project.

Trial version of PDF.co Web API is available for free. Source code samples are included to help you with your cURL app.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore Documentation](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Explore Source Code Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://app.pdf.co/signup?utm_source=github-readme)
[Security](https://pdf.co/security)
[Explore Web API Documentation](https://apidocs.pdf.co?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### **AddTextToExistingPDF.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source PDF file.
set SourceFileUrl=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf

::Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
::set Pages=

:: PDF document password. Leave empty for unprotected documents.
::set Password=

:: Destination PDF file name
set DestinationFile=result.pdf

:: Text annotation params
set Type=annotation
set X=400
set Y=600
set Text=APPROVED
set FontName=Times%20New%20Roman
set FontSize=24
set Color=FF0000

:: * Add Text *
:: Prepare request to `PDF Edit` API endpoint
set QUERY="https://api.pdf.co/v1/pdf/edit/add?name=%DestinationFile%&password=&pages=&url=%SourceFileUrl%&type=%Type%&x=%X%&y=%Y%&text=%Text%&fontname=%FontName%&size=%FontSize%&color=%Color%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)

echo.
pause
```

<!-- code block end -->