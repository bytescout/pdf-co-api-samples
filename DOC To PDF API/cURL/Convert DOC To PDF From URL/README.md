## How to convert DOC to PDF from URL for DOC to PDF API in cURL and PDF.co Web API

### See how to convert DOC to PDF from URL to have DOC to PDF API in cURL

Source code documentation samples provide quick and easy way to add a required functionality into your application. DOC to PDF API in cURL can be implemented with PDF.co Web API. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

The SDK samples like this one below explain how to quickly make your application do DOC to PDF API in cURL with the help of PDF.co Web API. Sample code in cURL is all you need. Copy-paste it to your the code editor, then add a reference to PDF.co Web API and you are ready to try it! Use of PDF.co Web API in cURL is also explained in the documentation included along with the product.

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

##### ****ConvertDocToPdfFromUrl.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source DOC or DOCX file.
set SOURCE_FILE_URL=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/doc-to-pdf/sample.docx
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `DOC To PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/from/doc?name=%RESULT_FILE_NAME%&url=%SOURCE_FILE_URL%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->