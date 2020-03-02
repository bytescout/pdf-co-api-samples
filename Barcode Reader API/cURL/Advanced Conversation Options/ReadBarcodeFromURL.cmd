@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source file to search barcodes in.
set SOURCE_FILE_URL=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf
:: Comma-separated list of barcode types to search. 
:: See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/read_from_url.html
set BARCODE_TYPES=Code128,Code39,Interleaved2of5,EAN13
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=


:: Some of advanced options available through profiles:
:: (JSON can be single/double-quoted and contain comments.)
:: {
::     "profiles": [
::         {
::             "profile1": {
::                 "ScanArea": "WholePage", // Values: "TopLeftQuarter", "TopRightQuarter", "BottomRightQuarter", "BottomLeftQuarter", "TopHalf", "BottomHalf", "WholePage".
::                 "RequireQuietZones": true, // Whether the quite zone is obligatory for 1D barcodes. Values: true / false
::                 "MaxNumberOfBarcodesPerPage": 0, // 0 - unlimited.
::                 "MaxNumberOfBarcodesPerDocument": 0, // 0 - unlimited.
::                 "ScanStep": 1, // Scan interval for linear (1-dimensional) barcodes.
::                 "MinimalDataLength": 0, // Minimal acceptable length of decoded data.                
::             }
::         }
::     ]
:: }
:: Advanced Options
set Profiles="{ 'profiles': [ { 'profile1': { 'FastMode': true } } ] }"

:: Prepare URL for `Barcode Reader` API endpoint
set QUERY="https://api.pdf.co/v1/barcode/read/from/url?types=%BARCODE_TYPES%&pages=%PAGES%&url=%SOURCE_FILE_URL%"

:: Perform request and save response to a file
%CURL% -g -# -X GET -H "x-api-key: %API_KEY%" %QUERY% -d Profiles >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get information about decoded barcodes.


echo.
pause