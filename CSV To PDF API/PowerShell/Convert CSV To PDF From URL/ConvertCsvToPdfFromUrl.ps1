# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source CSV file.
$SourceFileURL = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/csv-to-pdf/sample.csv"
# Destination PDF file name
$DestinationFile = ".\result.pdf"


# Prepare URL for `CSV To PDF` API call
$query = "https://api.pdf.co/v1/pdf/convert/from/csv?name=$(Split-Path $DestinationFile -Leaf)&url=$($SourceFileURL)"
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

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
catch {
    # Display request error
    Write-Host $_.Exception
}
