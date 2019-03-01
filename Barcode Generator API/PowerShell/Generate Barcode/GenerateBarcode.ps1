# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Result file name
$ResultFile = ".\barcode.png"
# Barcode type. See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/generate.html
$BarcodeType = "Code128"
# Barcode value
$BarcodeValue = "qweasd123456"


$resultFileName = [System.IO.Path]::GetFileName($ResultFile)
$query = "https://api.pdf.co/v1/barcode/generate?name=$($resultFileName)&type=$($BarcodeType)&value=$($BarcodeValue)"
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Get URL of generated barcode image file
        $resultFileUrl = $jsonResponse.url
        
        # Download the image file
        Invoke-WebRequest -Uri $resultFileUrl -OutFile $ResultFile

        Write-Host "Generated barcode saved to '$($ResultFile)' file."
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
