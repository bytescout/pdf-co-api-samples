# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source file to search barcodes in.
$SourceFileURL = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/barcode-reader/sample.pdf"
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
