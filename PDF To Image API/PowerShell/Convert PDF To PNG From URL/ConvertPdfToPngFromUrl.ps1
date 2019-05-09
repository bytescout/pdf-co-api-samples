# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source PDF file
$SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""
# PDF document password. Leave empty for unprotected documents.
$Password = ""


# Prepare URL for `PDF To PNG` API call
$query = "https://api.pdf.co/v1/pdf/convert/to/png?password={0}&pages={1}&url={2}" -f `
    $Password, $Pages, $SourceFileUrl
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Download generated PNG files
        $part = 1;
        foreach ($url in $jsonResponse.urls) {
            $localFileName = ".\page$($part).png"

            Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $localFileName -Uri $url

            Write-Host "Downloaded `"$($localFileName)`""
            $part++
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
