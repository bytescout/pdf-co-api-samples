## How to generate PDF invoice from HTML template for HTML to PDF API in PowerShell using PDF.co Web API

### Step By Step Tutorial: how to generate PDF invoice from HTML template for HTML to PDF API in PowerShell

Today we will explain the steps and algorithm of how to generate PDF invoice from HTML template and how to make it work in your application. PDF.co Web API was made to help with HTML to PDF API in PowerShell. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

Fast application programming interfaces of PDF.co Web API for PowerShell plus the instruction and the code below will help to learn how to generate PDF invoice from HTML template. For implimentation of this functionality, please copy and paste code below into your app using code editor. Then compile and run your app. Enjoy writing a code with ready-to-use sample PowerShell codes to add HTML to PDF API functions using PDF.co Web API in PowerShell.

ByteScout free trial version is available for FREE download from our website. Programming tutorials along with source code samples are included.

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

##### **GeneratePdfInvoiceFromHtmlTemplate.ps1:**
    
```
# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
$API_KEY = "***********************************"

# HTML template
$Template = [IO.File]::ReadAllText(".\invoice_template.html")
# Data to fill the template
$TemplateData = [IO.File]::ReadAllText(".\invoice_data.json")
# Destination PDF file name
$DestinationFile = ".\result.pdf"

# Prepare URL for HTML to PDF API call
$query = "https://api.pdf.co/v1/pdf/convert/from/html?name=$(Split-Path $DestinationFile -Leaf)"
$query = [System.Uri]::EscapeUriString($query)

# Prepare request body (will be auto-converted to JSON by Invoke-RestMethod)
$body = @{
    "html" = $Template
    "templateData" = $TemplateData
} | ConvertTo-Json

try {
    # Execute request
    $response = Invoke-WebRequest -Method Post -Headers @{ "x-api-key" = $API_KEY; "Content-Type" = "application/json" } -Body $body -Uri $query

    if ($response.StatusCode -eq 200) {
        
        $jsonResponse = $response.Content | ConvertFrom-Json

        if ($jsonResponse.error -eq $false) {
            # Get URL of generated PDF file
            $resultFileUrl = $jsonResponse.url;
            
            # Download PDF file
            Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $DestinationFile -Uri $resultFileUrl

            Write-Host "Generated PDF file saved as `"$($DestinationFile)`" file."
        }
        else {
            # Display service reported error
            Write-Host $jsonResponse.message
        }
    }
    else {
        # Display request error status
        Write-Host $response.StatusCode + " " + $response.StatusDescription
    }
}
catch {
    # Display request error
    Write-Host $_.Exception
}

```

<!-- code block end -->    

<!-- code block begin -->

##### **invoice_data.json:**
    
```
{
    "number": "1234567",
    "date": "April 30, 2016",
    "from": "Acme Inc., City, Street 3rd , +1 888 123-456, support@example.com",
    "to": "Food Delivery Inc., New York, Some Street, 42",
    "lines": [{
        "title": "Setting up new web-site",
        "quantity": 3,
        "price": 50
    }, {
        "title": "Configuring mail server and mailboxes",
        "quantity": 5,
        "price": 50
    }]
}
```

<!-- code block end -->    

<!-- code block begin -->

##### **run.bat:**
    
```
@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GeneratePdfInvoiceFromHtmlTemplate.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->