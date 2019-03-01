@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source PDF file.
set SOURCE_FILE_URL=https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/pdf-to-excel/sample.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Result XLS file name
set RESULT_FILE_NAME=result.xls


:: Prepare URL for `PDF To XLS` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/xls?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&url=%SOURCE_FILE_URL%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause