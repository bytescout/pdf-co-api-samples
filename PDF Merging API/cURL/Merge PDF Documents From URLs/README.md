## How to merge PDF documents from urls for PDF merging API in cURL with PDF.co Web API

### Step By Step Tutorial: how to merge PDF documents from urls for PDF merging API in cURL

Today we will explain the steps and algorithm of how to merge PDF documents from urls and how to make it work in your application. PDF.co Web API helps with PDF merging API in cURL. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

CURL code snippet like this for PDF.co Web API works best when you need to quickly implement PDF merging API in your cURL application. Sample code in cURL is all you need. Copy-paste it to your the code editor, then add a reference to PDF.co Web API and you are ready to try it! Writing cURL application typically includes multiple stages of the software development so even if the functionality works please test it with your data and the production environment.

Trial version of ByteScout is available for free download from our website. This and other source code samples for cURL and other programming languages are available.

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

##### **MergePdfDocumentsFromUrls.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URLs of PDF documents to merge
set SOURCE_FILE_URL1=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf
set SOURCE_FILE_URL2=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample2.pdf
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `Merge PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/merge?name=%RESULT_FILE_NAME%&url=%SOURCE_FILE_URL1%,%SOURCE_FILE_URL2%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->