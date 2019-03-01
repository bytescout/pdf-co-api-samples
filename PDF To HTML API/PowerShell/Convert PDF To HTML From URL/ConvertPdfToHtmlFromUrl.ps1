# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source PDF file.
$SourceFileUrl = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/pdf-to-html/sample.pdf"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""
# PDF document password. Leave empty for unprotected documents.
$Password = ""
# Destination HTML file name
$DestinationFile = ".\result.html"
# Set to $true to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
$PlainHtml = $false
# Set to $true if your document has the column layout like a newspaper.
$ColumnLayout = $false



# Prepare URL for `PDF To HTML` API call
$query = "https://api.pdf.co/v1/pdf/convert/to/html?name={0}&password={1}&pages={2}&simple={3}&columns={4}&url={5}" -f `
    $(Split-Path $DestinationFile -Leaf), $Password, $Pages, $PlainHtml, $ColumnLayout, $SourceFileUrl
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Get URL of generated HTML file
        $resultFileUrl = $jsonResponse.url;
        
        # Download HTML file
        Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $DestinationFile -Uri $resultFileUrl

        Write-Host "Generated HTML file saved as `"$($DestinationFile)`" file."
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
