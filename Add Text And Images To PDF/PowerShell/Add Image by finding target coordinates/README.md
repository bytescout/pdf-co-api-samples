## How to add text and images to PDF in PowerShell and PDF.co Web API

### This code in PowerShell shows how to add text and images to PDF with this how to tutorial

Sample source code below will show you how to cope with a difficult task like add text and images to PDF in PowerShell. What is PDF.co Web API? It is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf. It can help you to add text and images to PDF in your PowerShell application.

PowerShell code samples for PowerShell developers help to speed up coding of your application when using PDF.co Web API. In your PowerShell project or application you may simply copy & paste the code and then run your app! Implementing PowerShell application typically includes multiple stages of the software development so even if the functionality works please test it with your data and the production environment.

Trial version of PDF.co Web API is available for free. Source code samples are included to help you with your PowerShell app.

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

##### ****AddImageByFindingTargetCoordinates.ps1:**
    
```
# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source PDF file.
$SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

# Search string.
$SearchString = 'Your Company Name'

# Prepare URL for PDF text search API call.
# See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html
$queryFindText = "https://api.pdf.co/v1/pdf/find?url=$($SourceFileURL)&searchString=$($SearchString)"
$queryFindText = [System.Uri]::EscapeUriString($queryFindText)

try {
    # Execute request
    $jsonResponseFindText = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $queryFindText

    if ($jsonResponseFindText.error -eq $false) {

        # Display search information
        $itemFindText = $jsonResponseFindText.body[0];

        Write-Host "Found text at coordinates $($itemFindText.left), $($itemFindText.top)"


        #Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
        $Pages = ""

        # PDF document password. Leave empty for unprotected documents.
        $Password = ""

        # Destination PDF file name
        $DestinationFile = "./result.pdf"

        # Image params
        $Type = "image"
        $X = 450
        $Y = $itemFindText.top
        $Width = 119
        $Height = 32
        $ImageUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png"

        $resultFileName = [System.IO.Path]::GetFileName($DestinationFile)

        # * Add image *
        # Prepare request to `PDF Edit` API endpoint
        $query = "https://api.pdf.co/v1/pdf/edit/add?name=$($resultFileName)&password=$($Password)&pages=$($Pages)&url=$($SourceFileUrl)&type=$($Type)&x=$($X)&y=$($Y)&width=$($Width)&height=$($Height)&urlimage=$($ImageUrl)";
        $query = [System.Uri]::EscapeUriString($query)

        try {
            # Execute request
            $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

            if ($jsonResponse.error -eq $false) {
                # Get URL of generated barcode image file
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

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddImageByFindingTargetCoordinates.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->