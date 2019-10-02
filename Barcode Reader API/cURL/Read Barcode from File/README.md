## How to read barcode from file for barcode reader API in cURL with PDF.co Web API

### Step By Step Instructions on how to read barcode from file for barcode reader API in cURL

Check these thousands of pre-made source code samples for simple implementation in your own programming projects. PDF.co Web API was designed to assist barcode reader API in cURL. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

The SDK samples displayed below below explain how to quickly make your application do barcode reader API in cURL with the help of PDF.co Web API. This cURL sample code can be used by copying and pasting into your project. Once done,just compile your project and click Run. Writing cURL application mostly includes various stages of the software development so even if the functionality works please check it with your data and the production environment.

PDF.co Web API - free trial version is available on our website. Also, there are other code samples to help you with your cURL application included into trial version.

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

##### ****Read-Barcode-from-File.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: Source file to search barcodes in.
set SOURCE_FILE=sample.pdf
:: Comma-separated list of barcode types to search. 
:: See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/read_from_url.html
set BARCODE_TYPES=Code128,Code39,Interleaved2of5,EAN13
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=

:: Prepare URL for `Barcode Reader` API endpoint
set QUERY="https://api.pdf.co/v1/barcode/read/from/url?types=%BARCODE_TYPES%&pages=%PAGES%"
echo %QUERY%

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" -F "file=@%SOURCE_FILE%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get information about decoded barcodes.


echo.
pause
```

<!-- code block end -->