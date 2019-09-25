## How to add text and images to PDF in PowerShell and PDF.co Web API

### How to code in PowerShell to add text and images to PDF with this step-by-step tutorial

Learn how to add text and images to PDF in PowerShell with this source code sample. PDF.co Web API: the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf. It can add text and images to PDF in PowerShell.

This code snippet below for PDF.co Web API works best when you need to quickly add text and images to PDF in your PowerShell application. Just copy and paste the code into your PowerShell application’s code and follow the instruction. This basic programming language sample code for PowerShell will do the whole work for you to add text and images to PDF.

You can download free trial version of PDF.co Web API from our website to see and try many others source code samples for PowerShell.

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

##### ****AddTextToExistingPDF.ps1:**
    
```
# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source PDF file.
$SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

#Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""

# PDF document password. Leave empty for unprotected documents.
$Password = ""

# Destination PDF file name
$DestinationFile = "./result.pdf"

# Text annotation params
$Type = "annotation";
$X = 400;
$Y = 600;
$Text = "APPROVED";
$FontName = "Times New Roman";
$FontSize = 24;
$Color = "FF0000";

$resultFileName = [System.IO.Path]::GetFileName($DestinationFile)

# * Add Text *
# Prepare request to `PDF Edit` API endpoint
$query = "https://api.pdf.co/v1/pdf/edit/add?name=$($resultFileName)&password=$($Password)&pages=$($Pages)&url=$($SourceFileUrl)&type=$($Type)&x=$($X)&y=$($Y)&text=$($Text)&fontname=$($FontName)&size=$($FontSize)&color=$($Color)";
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Get URL of generated output file
        $resultFileUrl = $jsonResponse.url
        
        # Download output file
        Invoke-WebRequest -Uri $resultFileUrl -OutFile $DestinationFile

        Write-Host "Generated PDF saved to '$($DestinationFile)' file."
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

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddTextToExistingPDF.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->