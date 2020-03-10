## PDF to text API in cURL using PDF.co Web API PDF.co Web API: the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

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

##### **ConvertPdfToTextFromUrl.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source PDF file.
set SOURCE_FILE_URL=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Result TXT file name
set RESULT_FILE_NAME=result.txt

::Some of advanced options available through profiles:
::(JSON can be single/double-quoted and contain comments.)
::{
::    "profiles": [
::        {
::            "profile1": {                
::                "ExtractInvisibleText": true, // Invisible text extraction. Values: true / false
::                "ExtractShadowLikeText": true, // Shadow-like text extraction. Values: true / false
::                "ExtractAnnotations": true, // Whether to extract PDF annotations.
::                "CheckPermissions": true, // Ignore document permissions. Values: true / false
::                "DetectNewColumnBySpacesRatio": 1.2, // A ratio affecting number of spaces between words. 
::            }
::        }
::    ]
::}

:: Sample profile that sets advanced conversion options
:: Advanced options are properties of TextExtractor class from ByteScout Text Extractor SDK used in the back-end:
:: https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/8a2bae5a-346f-8338-b5aa-6f3522dca0d4.htm
set Profiles="{ 'profiles': [ { 'profile1': { 'TrimSpaces': 'False', 'PreserveFormattingOnTextExtraction': 'True', 'Unwrap': 'True' } } ] }"

:: Prepare URL for `PDF To Text` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/text?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&url=%SOURCE_FILE_URL%"

:: Perform request and save response to a file
%CURL% -g -# -X GET -H "x-api-key: %API_KEY%" %QUERY% -d Profiles >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->