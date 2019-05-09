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