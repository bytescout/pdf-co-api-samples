## How to parse from url for document parser API in Powershell and PDF.co Web API

### Learn in simple ways: How to parse from url for document parser API in Powershell

Quick guide:Learn how to parse from url in Powershell. PDF.co Web API was designed to assist document parser API in Powershell. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

Want to learn quickly? These fast application programming interfaces of PDF.co Web API for Powershell plus the instruction and the code below will help to learn how to parse from url. This Powershell sample code can be used by copying and pasting into your project. Once done,just compile your project and click Run. Further improvement of the code will make it more robust.

Our website provides free trial version of PDF.co Web API that gives source code samples to assist with your Powershell project.

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

##### ****MultiPageTable-template1.yml:**
    
```
---
# Template that demonstrates parsing of multi-page table using only 
# regular expressions for the table start, end, and rows.
# If regular expression cannot be written for every table row (for example, 
# if the table contains empty cells), try the second method demonstrated 
# in 'MultiPageTable-template2.yml' template.
templateVersion: 2
templatePriority: 0
sourceId: Multipage Table Test
detectionRules:
  keywords:
  - Sample document with multi-page table
fields:
  total:
    expression: TOTAL {{DECIMAL}}    
tables:
- name: table1
  start:
    # regular expression to find the table start in document
    expression: Item\s+Description\s+Price\s+Qty\s+Extended Price
  end:
    # regular expression to find the table end in document
    expression: TOTAL\s+\d+\.\d\d
  row:
    # regular expression to find table rows
    expression: '^\s*(?<itemNo>\d+)\s+(?<description>.+?)\s+(?<price>\d+\.\d\d)\s+(?<qty>\d+)\s+(?<extPrice>\d+\.\d\d)'
  columns: 
  - name: itemNo
    type: integer
  - name: description
    type: string
  - name: price
    type: decimal
  - name: qty
    type: integer
  - name: extPrice
    type: decimal
  multipage: true
```

<!-- code block end -->    

<!-- code block begin -->

##### ****ParseFromUrl.ps1:**
    
```
# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Source PDF file url
$SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/document-parser/MultiPageTable.pdf"

# Destination JSON file name
$DestinationFile = ".\result.json"


try {
    # Parse url
    # Template text. Use Document Parser SDK (https://bytescout.com/products/developer/documentparsersdk/index.html)
    # to create templates.
    # Read template from file:
    $templateContent = [IO.File]::ReadAllText(".\MultiPageTable-template1.yml")

    # Prepare URL for `Document Parser` API call
    $query = "https://api.pdf.co/v1/pdf/documentparser"

    # Content
    $Body = @{
        "url" = $SourceFileUrl;
        "template" = $templateContent;
    }
    
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method 'Post' -Headers @{ "x-api-key" = $API_KEY } -Uri $query -Body ($Body|ConvertTo-Json) -ContentType "application/json"
    if ($jsonResponse.error -eq $false) {
        # Get URL of generated HTML file
        $resultFileUrl = $jsonResponse.url;
        
        # Download output file
        Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $DestinationFile -Uri $resultFileUrl
        Write-Host "Generated output file saved as `"$($DestinationFile)`" file."
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

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ParseFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause
```

<!-- code block end -->