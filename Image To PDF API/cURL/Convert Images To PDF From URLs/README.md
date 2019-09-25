## How to convert images to PDF from urls for image to PDF API in cURL and PDF.co Web API

### How to convert images to PDF from urls for image to PDF API in cURL: How To Tutorial

Source code documentation samples provide quick and easy way to add a required functionality into your application. PDF.co Web API was made to help with image to PDF API in cURL. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

The SDK samples like this one below explain how to quickly make your application do image to PDF API in cURL with the help of PDF.co Web API. Sample code in cURL is all you need. Copy-paste it to your the code editor, then add a reference to PDF.co Web API and you are ready to try it! Tutorials are available along with installed PDF.co Web API if you'd like to dive deeper into the topic and the details of the API.

ByteScout free trial version is available for FREE download from our website. Programming tutorials along with source code samples are included.

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

##### ****ConvertImagesToPdfFromUrls.cmd:**
    
```
@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URLs of image files to convert to PDF document
set SOURCE_IMAGE_URL1=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/image-to-pdf/image1.png
set SOURCE_IMAGE_URL2=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/image-to-pdf/image2.jpg
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `Image To PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/from/image?name=%RESULT_FILE_NAME%&url=%SOURCE_IMAGE_URL1%,%SOURCE_IMAGE_URL2%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause
```

<!-- code block end -->