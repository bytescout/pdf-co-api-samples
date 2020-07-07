## How to convert PDF to HTML from file for PDF to HTML API in cURL and PDF.co Web API

### Learn in simple ways: How to convert PDF to HTML from file for PDF to HTML API in cURL

Every ByteScout tool includes sample cURL source codes that you can find here or in the folder with installed ByteScout product. PDF.co Web API was designed to assist PDF to HTML API in cURL. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

If you want to speed up the application’s code writing then cURL code samples for cURL developers help to implement using PDF.co Web API. This cURL sample code can be used by copying and pasting into your project. Once done,just compile your project and click Run. Enjoy writing a code with ready-to-use sample cURL codes to implement PDF to HTML API using PDF.co Web API.

Free! Free! Free! ByteScout free trial version is available for FREE download from our website. Programming tutorials along with source code samples are assembled.

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

##### **Convert-PDF-to-HTML-from-File.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: PDF file.
set SOURCE_FILE=sample.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Result HTML file name
set RESULT_FILE_NAME=result.html
:: Set to `true` to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
set PLAIN_HTML=false
:: Set to `true` if your document has the column layout like a newspaper.
set COLUMN_LAYOUT=false


:: Prepare URL for `PDF To HTML` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/html?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&simple=%PLAIN_HTML%&columns=%COLUMN_LAYOUT%"
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