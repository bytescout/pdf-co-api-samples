## How to add text and images to PDF in cURL using PDF.co Web API

### Learning is essential in computer world and the tutorial below will demonstrate how to add text and images to PDF in cURL

The sample source code below will teach you how to add text and images to PDF in cURL. Want to add text and images to PDF in your cURL app? PDF.co Web API is designed for it. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

The following code snippet for PDF.co Web API works best when you need to quickly add text and images to PDF in your cURL application. IF you want to implement the functionality, just copy and paste this code for cURL below into your code editor with your app, compile and run your application. Enjoy writing a code with ready-to-use sample cURL codes.

You can download free trial version of PDF.co Web API from our website to see and try many others source code samples for cURL.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore SDK Docs](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Documentation](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### ****AddImageToExistingPDF.cmd:**
    
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

:: Image params
set Type=image
set X=400
set Y=20
set Width=119
set Height=32
set ImageUrl=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png

:: * Add image *
:: Prepare request to `PDF Edit` API endpoint
set query="https://api.pdf.co/v1/pdf/edit/add?name=%DestinationFile%&password=&pages=&url=%SourceFileUrl%&type=%Type%&x=%X%&y=%Y%&width=%Width%&height=%Height%&urlimage=%ImageUrl%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)

echo.
pause
```

<!-- code block end -->