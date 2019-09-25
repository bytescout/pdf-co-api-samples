## How to convert web page to PDF from link for HTML to PDF API in cURL with PDF.co Web API

### Learn how to convert web page to PDF from link to have HTML to PDF API in cURL

Source code documentation samples provide quick and easy way to add a required functionality into your application. PDF.co Web API helps with HTML to PDF API in cURL. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

CURL code snippet like this for PDF.co Web API works best when you need to quickly implement HTML to PDF API in your cURL application. Follow the instruction and copy - paste code for cURL into your project's code editor. This basic programming language sample code for cURL will do the whole work for you in implementing HTML to PDF API in your app.

Trial version of ByteScout is available for free download from our website. This and other source code samples for cURL and other programming languages are available.

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

##### ****ConvertWebPageToPdfFromLink.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: URL of web page to convert to PDF document.
set SOURCE_URL=http://www.usa.gov
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `Web Page to PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/from/url?name=%RESULT_FILE_NAME%&url=%SOURCE_URL%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->