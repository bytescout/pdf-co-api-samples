## How to split PDF from file for PDF splitting API in cURL using PDF.co Web API

### Learn to write code split PDF from file for PDF splitting API in cURL: Simple How To Tutorial

Quick guide:Learn how to split PDF from file in cURL. PDF splitting API in cURL can be applied with PDF.co Web API. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

The SDK samples displayed below below explain how to quickly make your application do PDF splitting API in cURL with the help of PDF.co Web API.  This sample code in cURL is all you need. Just copy-paste it to the code editor, then add a reference to PDF.co Web API and you are ready to try it!  Easy to understand tutorials are available along with installed PDF.co Web API if you'd like to learn more about the topic and the details of the API.

Our website provides free trial version of PDF.co Web API that gives source code samples to assist with your cURL project.

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

##### ****Split-PDF-from-File.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: PDF file.
set SOURCE_FILE=sample.pdf
:: Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
set PAGES=1-2,3-
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `Split PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/split?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%"
echo %QUERY%

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" -F "file=@%SOURCE_FILE%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->