## How to generate barcode for barcode generator API in cURL and PDF.co Web API

### Learn how to generate barcode to have barcode generator API in cURL

The sample source codes on this page will demonstrate you how to make barcode generator API in cURL. PDF.co Web API helps with barcode generator API in cURL. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

Fast application programming interfaces of PDF.co Web API for cURL plus the instruction and the code below will help to learn how to generate barcode. Open your cURL project and simply copy & paste the code and then run your app! Code testing will allow the function to be tested and work properly with your data.

PDF.co Web API - free trial version is on available our website. Also, there are other code samples to help you with your cURL application included into trial version.

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

##### ****GenerateBarcode.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Barcode type. See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/generate.html
set BARCODE_TYPE=Code128
:: Barcode value
set BARCODE_VALUE=qweasd123456
:: Result image file name
set RESULT_FILE_NAME=barcode.png

:: Prepare URL for `Barcode Generator` API endpoint
set QUERY="https://api.pdf.co/v1/barcode/generate?name=%RESULT_FILE_NAME%&type=%BARCODE_TYPE%&value=%BARCODE_VALUE%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json


:: Use any convenient way to parse JSON response and get URL of generated file(s)

echo.
pause
```

<!-- code block end -->