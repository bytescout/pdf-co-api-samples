## How to PDF make searchable API in cURL using PDF.co Web API

### Continuous learning is a crucial part of computer science and this tutorial shows how to PDF make searchable API in cURL

These sample source codes on this page below are displaying how to PDF make searchable API in cURL. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf. It can be applied to PDF make searchable API using cURL.

Want to quickly learn? This fast application programming interfaces of PDF.co Web API for cURL plus the guidelines and the code below will help you quickly learn how to PDF make searchable API.  Simply copy and paste in your cURL project or application you and then run your app! Complete and detailed tutorials and documentation are available along with installed PDF.co Web API if you'd like to learn more about the topic and the details of the API.

PDF.co Web API free trial version is available on our website. cURL and other programming languages are supported.

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

##### ****Make-Searchable-PDF-from-File.cmd:**
    
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
:: OCR language. "eng", "fra", "deu", "spa"  supported currently. Let us know if you need more.
set LANGUAGE=eng
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `Make Searchable PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/makesearchable?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&lang=%LANGUAGE%"
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