## How to add text and images to PDF in PowerShell using PDF.co Web API

### How to code in PowerShell to add text and images to PDF with this step-by-step tutorial

The sample source code below will teach you how to add text and images to PDF in PowerShell. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf. It can be used to add text and images to PDF using PowerShell.

The SDK samples like this one below explain how to quickly make your application do add text and images to PDF in PowerShell with the help of PDF.co Web API. Follow the instructions from the scratch to work and copy the PowerShell code. Implementing PowerShell application typically includes multiple stages of the software development so even if the functionality works please test it with your data and the production environment.

Free trial version of PDF.co Web API is available for download from our website. Get it to try other source code samples for PowerShell.

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

##### **AddTextByFindingTargetCoordinates.ps1:**
    
```
# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source PDF file.
$SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

# Search string.
$SearchString = 'Notes'

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

        # Text annotation params
        $Type = "annotation";
        $X = $itemFindText.left;
        $Y = $itemFindText.top + 25;
        $Text = "Some notes will go here... Some notes will go here.... Some notes will go here.....";
        $FontName = "Times New Roman";
        $FontSize = 12;
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

##### **run.bat:**
    
```
@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddTextByFindingTargetCoordinates.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->