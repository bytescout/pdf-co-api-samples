@echo off

:: Path of the cURL executable
set CURL="curl.exe"

:: The authentication key (API Key).
:: Get your own by registering at https://app.pdf.co/documentation/api
set API_KEY=***********************************

:: Direct URL of source PDF file.
set SOURCE_FILE_URL=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-excel/sample.pdf
:: Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
set PAGES=
:: PDF document password. Leave empty for unprotected documents.
set PASSWORD=
:: Result XLS file name
set RESULT_FILE_NAME=result.xls

:: Some of advanced options available through profiles:
:: (JSON can be single/double-quoted and contain comments.)
:: {
::     "profiles": [
::         {
::             "profile1": {
::                 "NumberDecimalSeparator": "", // Allows to customize decimal separator in numbers.
::                 "NumberGroupSeparator": "", // Allows to customize thousands separator.
::                 "AutoDetectNumbers": true, // Whether to detect numbers. Values: true / false
::                 "RichTextFormatting": true, // Whether to keep text style and fonts. Values: true / false
::                 "PageToWorksheet": true, // Whether to create separate worksheet for each page of PDF document. Values: true / false
::                 "ExtractInvisibleText": true, // Invisible text extraction. Values: true / false
::                 "ExtractShadowLikeText": true, // Shadow-like text extraction. Values: true / false
::                 "LineGroupingMode": "None", // Values: "None", "GroupByRows", "GroupByColumns", "JoinOrphanedRows"
::                 "ColumnDetectionMode": "ContentGroupsAndBorders", // Values: "ContentGroupsAndBorders", "ContentGroups", "Borders", "BorderedTables"
::                 "Unwrap": false, // Unwrap grouped text in table cells. Values: true / false
::                 "ShrinkMultipleSpaces": false, // Shrink multiple spaces in table cells that affect column detection. Values: true / false
::                 "DetectNewColumnBySpacesRatio": 1, // Spacing ratio that affects column detection.
::                 "CustomExtractionColumns": [ 0, 50, 150, 200, 250, 300 ], // Explicitly specify columns coordinates for table extraction.
::                 "CheckPermissions": true, // Ignore document permissions. Values: true / false
::             }
::         }
::     ]
:: }
:: Sample profile that sets advanced conversion options.
:: Advanced options are properties of XLSExtractor class from ByteScout PDF Extractor SDK used in the back-end:
:: https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/2712c05b-9674-5253-df76-2a31ed055afd.htm
set Profiles="{ 'profiles': [ { 'profile1': { 'RichTextFormatting': false, 'PageToWorksheet': false } } ] }"

:: Prepare URL for `PDF To XLS` API call
set QUERY="https://api.pdf.co/v1/pdf/convert/to/xls?name=%RESULT_FILE_NAME%&password=%PASSWORD%&pages=%PAGES%&url=%SOURCE_FILE_URL%"

:: Perform request and save response to a file
%CURL% -g -# -X GET -H "x-api-key: %API_KEY%" %QUERY% -d Profiles >response.json

:: Display the response
type response.json

:: Use any convenient way to parse JSON response and get URL of generated file(s)


echo.
pause