@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=#################################


:: Input url file
set InputUrl=https://www.wikipedia.org

:: Result image file name
set RESULT_FILE_NAME=result.png

:: Prepare URL for `Urlto Png` API endpoint
set QUERY="https://api.pdf.co/v1/url/convert/to/png?name=%RESULT_FILE_NAME%&url=%InputUrl%"

echo %QUERY%

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)

echo.
pause