@echo on

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=

:: DOC file.
set SOURCE_FILE=sample.docx
:: Result PDF file name
set RESULT_FILE_NAME=result.pdf


:: Prepare URL for `DOC to PDF` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/from/doc?name=%RESULT_FILE_NAME%"
echo %QUERY%

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" -F "file=@%SOURCE_FILE%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause