## barcode reader API in PowerShell using PDF.co Web API

### How to use PDF.co Web API for barcode reader API in PowerShell

Writing of the code to barcode reader API in PowerShell can be done by developers of any level using PDF.co Web API. Barcode reader API in PowerShell can be implemented with PDF.co Web API. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

Fast application programming interfaces of PDF.co Web API for PowerShell plus the instruction and the PowerShell code below will help you quickly learn barcode reader API. This PowerShell sample code should be copied and pasted into your application’s code editor. Then just compile and run it to see how it works. Enhanced documentation and tutorials are available along with installed PDF.co Web API if you'd like to dive deeper into the topic and the details of the API.

Free trial version of PDF.co Web API is available on our website. Get it to try other samples for PowerShell.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore SDK Docs](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Documentation](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### ****ReadBarcodeFromURL.ps1:**
    
```
# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source file to search barcodes in.
$SourceFileURL = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf"
# Comma-separated list of barcode types to search. 
# See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/read_from_url.html
$BarcodeTypes = "Code128,Code39,Interleaved2of5,EAN13"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""

# Sample profile that sets advanced conversion options
# Advanced options are properties of Reader class from Bytescout BarCodeReader used in the back-end:
# https://cdn.bytescout.com/help/BytescoutBarCodeReaderSDK/html/ba101d21-3db7-eb54-d112-39cadc023d02.htm
$Profiles = '{ "profiles": [ { "profile1": { "FastMode": true } } ] }'

# Prepare URL for `Barcode Reader` API call
$query = "https://api.pdf.co/v1/barcode/read/from/url?types=$($BarcodeTypes)&pages=$($Pages)&url=$($SourceFileURL)&profiles=$($Profiles)"
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Display found barcodes in console
        foreach ($barcode in $jsonResponse.barcodes)
        {
            Write-Host "Found barcode:"
            Write-Host "  Type: " $barcode.TypeName
            Write-Host "  Value: " $barcode."Value"
            Write-Host "  Document Page Index: " $barcode."Page"
            Write-Host "  Rectangle: " $barcode."Rect"
            Write-Host "  Confidence: " $barcode."Confidence"
            Write-Host ""
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

##### ****run.bat:**
    
```
@echo off

echo (Get-Location).Path

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReadBarcodeFromURL.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->