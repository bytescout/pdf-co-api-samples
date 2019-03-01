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