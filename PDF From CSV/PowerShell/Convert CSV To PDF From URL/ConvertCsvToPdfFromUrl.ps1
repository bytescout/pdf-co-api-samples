# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
$API_KEY = "***********************************"

# Direct URL of source CSV file.
$SourceFileURL = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/csv-to-pdf/sample.csv"
# Destination PDF file name
$DestinationFile = ".\result.pdf"


# Prepare URL for `CSV To PDF` API call
$query = "https://api.pdf.co/v1/pdf/convert/from/csv"

# Prepare request body (will be auto-converted to JSON by Invoke-RestMethod)
# See documentation: https://apidocs.pdf.co
$body = @{
    "name" = $(Split-Path $DestinationFile -Leaf)
    "url" = $SourceFileURL
} | ConvertTo-Json

try {
    # Execute request
    $response = Invoke-WebRequest -Method Post -Headers @{ "x-api-key" = $API_KEY; "Content-Type" = "application/json" } -Body $body -Uri $query

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
catch {
    # Display request error
    Write-Host $_.Exception
}
