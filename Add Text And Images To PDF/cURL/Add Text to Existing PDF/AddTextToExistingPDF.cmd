@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source PDF file.
set SourceFileUrl=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf

::Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
::set Pages=

:: PDF document password. Leave empty for unprotected documents.
::set Password=

:: Destination PDF file name
set DestinationFile=result.pdf

:: Text annotation params
set Type=annotation
set X=400
set Y=600
set Text=APPROVED
set FontName=Times%20New%20Roman
set FontSize=24
set Color=FF0000

:: * Add Text *
:: Prepare request to `PDF Edit` API endpoint
set QUERY="https://api.pdf.co/v1/pdf/edit/add?name=%DestinationFile%&password=&pages=&url=%SourceFileUrl%&type=%Type%&x=%X%&y=%Y%&text=%Text%&fontname=%FontName%&size=%FontSize%&color=%Color%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)

echo.
pause