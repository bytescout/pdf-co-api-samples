@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Source PDF file to split
set SOURCE_FILE_URL=https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/pdf-split/sample.pdf
:: Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
set PAGES=1-2,3-
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `Split PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/split?name=%RESULT_FILE_NAME%&pages=%PAGES%&url=%SOURCE_FILE_URL%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause