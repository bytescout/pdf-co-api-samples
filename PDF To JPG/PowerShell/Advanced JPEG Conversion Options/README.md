## PDF to image API in PowerShell using PDF.co Web API PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore Documentation](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Explore Source Code Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://app.pdf.co/signup?utm_source=github-readme)
[Security](https://pdf.co/security)
[Explore Web API Documentation](https://apidocs.pdf.co?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### **ConvertPdfToJpegFromUrl.ps1:**
    
```
# The following options are available through profiles:
# (JSON can be single/double-quoted and contain comments.)
# {
#     "profiles": [
#         {
#             "profile1": {
#                 "TextSmoothingMode": "HighQuality", // Valid values: "HighSpeed", "HighQuality"
#                 "VectorSmoothingMode": "HighQuality", // Valid values: "HighSpeed", "HighQuality"
#                 "ImageInterpolationMode": "HighQuality", // Valid values: "HighSpeed", "HighQuality"
#                 "RenderTextObjects": true, // Valid values: true, false
#                 "RenderVectorObjects": true, // Valid values: true, false
#                 "RenderImageObjects": true, // Valid values: true, false
#                 "RenderCurveVectorObjects": true, // Valid values: true, false
#                 "JPEGQuality": 85, // from 0 (lowest) to 100 (highest)
#                 "TIFFCompression": "LZW", // Valid values: "None", "LZW", "CCITT3", "CCITT4", "RLE"
#                 "RotateFlipType": "RotateNoneFlipNone", // RotateFlipType enum values from here: https://docs.microsoft.com/en-us/dotnet/api/system.drawing.rotatefliptype?view=netframework-2.0
#                 "ImageBitsPerPixel": "BPP24", // Valid values: "BPP1", "BPP8", "BPP24", "BPP32"
#                 "OneBitConversionAlgorithm": "OtsuThreshold", // Valid values: "OtsuThreshold", "BayerOrderedDithering"
#                 "FontHintingMode": "Default", // Valid values: "Default", "Stronger"
#                 "NightMode": false // Valid values: true, false
#             }
#         }
#     ]
# }


# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
$API_KEY = "***********************************"

# Direct URL of source PDF file.
$SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""
# PDF document password. Leave empty for unprotected documents.
$Password = ""
# Advanced Optoins
$Profiles = "{ 'profiles': [ { 'profile1': { 'JPEGQuality': '25' } } ] }"

# Prepare URL for `PDF To JPEG` API call
$query = "https://api.pdf.co/v1/pdf/convert/to/jpg"

# Prepare request body (will be auto-converted to JSON by Invoke-RestMethod)
# See documentation: https://apidocs.pdf.co
$body = @{
    "password" = $Password
    "pages" = $Pages
    "url" = $SourceFileUrl
    "profiles" = $Profiles
} | ConvertTo-Json

try {
    # Execute request
    $response = Invoke-WebRequest -Method Post -Headers @{ "x-api-key" = $API_KEY; "Content-Type" = "application/json" } -Body $body -Uri $query

    $jsonResponse = $response.Content | ConvertFrom-Json

    if ($jsonResponse.error -eq $false) {
        # Download generated JPEG files
        $part = 1;
        foreach ($url in $jsonResponse.urls) {
            $localFileName = ".\page$($part).jpg"

            Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $localFileName -Uri $url

            Write-Host "Downloaded `"$($localFileName)`""
            $part++
        }
    }
    else {
        # Display service reported error
        Write-Host $jsonResponse.message
    }
}
catch {
    # Display request error
    Write-Host $_.Exception
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **run.bat:**
    
```
@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToJpegFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->