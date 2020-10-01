# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of PDF file to get information
$SourceFileURL = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf"


# Prepare URL for `Invoice Parser` API call
$query = "https://api.pdf.co/v1/pdf/invoiceparser"

# Prepare request body (will be auto-converted to JSON by Invoke-RestMethod)
# See documentation: https://apidocs.pdf.co
$body = @{
    "url" = $SourceFileURL
    "inline" = True
} | ConvertTo-Json

try {
    # Execute request
    $response = Invoke-WebRequest -Method Post -Headers @{ "x-api-key" = $API_KEY; "Content-Type" = "application/json" } -Body $body -Uri $query

    $jsonResponse = $response.Content | ConvertFrom-Json

    if ($jsonResponse.error -eq $false) {
        # Display PDF document information
        Write-Host $jsonResponse.body
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
