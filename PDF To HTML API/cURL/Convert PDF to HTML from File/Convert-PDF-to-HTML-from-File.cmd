@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: PDF file.
set SOURCE_FILE=sample.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Result HTML file name
set RESULT_FILE_NAME=result.html
:: Set to `true` to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
set PLAIN_HTML=false
:: Set to `true` if your document has the column layout like a newspaper.
set COLUMN_LAYOUT=false


:: Prepare URL for `PDF To HTML` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/html?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&simple=%PLAIN_HTML%&columns=%COLUMN_LAYOUT%"
echo %QUERY%

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" -F "file=@%SOURCE_FILE%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause