## PDF to text API in cURL using PDF.co Web API PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

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

##### **Convert-PDF-to-Text-from-File.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: Direct URL of source PDF file.
set SOURCE_FILE_URL=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample-rotated.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Destination JSON file name
set RESULT_FILE_NAME=result.json


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
:: Advanced options are properties of CSVExtractor class from ByteScout PDF Extractor SDK used in the back-end:
:: https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/87ce5fa6-3143-167d-abbd-bc7b5e160fe5.htm

:: Valid RotationAngle values:
:: 0 - no rotation
:: 1 - 90 degrees
:: 2 - 180 degrees
:: 3 - 270 degrees
set Profiles = "{ 'profiles': [{ 'profile1': { 'RotationAngle': 1 } } ] }"

:: Prepare URL for `PDF To JSON` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/json?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&url=%SOURCE_FILE_URL%"
echo %QUERY%

:: Perform request and save response to a file
%CURL% -g -# -X GET -H "x-api-key: %API_KEY%" %QUERY% -d Profiles >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->