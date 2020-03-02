:: The following options are available through profiles:
:: (JSON can be single/double-quoted and contain comments.)
:: {
::     "profiles": [
::         {
::             "profile1": {
::                 "TextSmoothingMode": "HighQuality", // Valid values: "HighSpeed", "HighQuality"
::                 "VectorSmoothingMode": "HighQuality", // Valid values: "HighSpeed", "HighQuality"
::                 "ImageInterpolationMode": "HighQuality", // Valid values: "HighSpeed", "HighQuality"
::                 "RenderTextObjects": true, // Valid values: true, false
::                 "RenderVectorObjects": true, // Valid values: true, false
::                 "RenderImageObjects": true, // Valid values: true, false
::                 "RenderCurveVectorObjects": true, // Valid values: true, false
::                 "JPEGQuality": 85, // from 0 (lowest) to 100 (highest)
::                 "TIFFCompression": "LZW", // Valid values: "None", "LZW", "CCITT3", "CCITT4", "RLE"
::                 "RotateFlipType": "RotateNoneFlipNone", // RotateFlipType enum values from here: https://docs.microsoft.com/en-us/dotnet/api/system.drawing.rotatefliptype?view=netframework-2.0
::                 "ImageBitsPerPixel": "BPP24", // Valid values: "BPP1", "BPP8", "BPP24", "BPP32"
::                 "OneBitConversionAlgorithm": "OtsuThreshold", // Valid values: "OtsuThreshold", "BayerOrderedDithering"
::                 "FontHintingMode": "Default", // Valid values: "Default", "Stronger"
::                 "NightMode": false // Valid values: true, false
::             }
::         }
::     ]
:: }

@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source PDF file.
set SOURCE_FILE_URL=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Advanced Options
set Profiles = "{ 'profiles': [ { 'profile1': { 'JPEGQuality': '25' } } ] }"

:: Prepare URL for `PDF To JPEG` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/jpg?password=%PASSWORD%&pages=%PAGES%&url=%SOURCE_FILE_URL%&profiles=%Profiles%"

:: Perform request and save response to a file
%CURL% -# -X GET -H "x-api-key: %API_KEY%" %QUERY% >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause