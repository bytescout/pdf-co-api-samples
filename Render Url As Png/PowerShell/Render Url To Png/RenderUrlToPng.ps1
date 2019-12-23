# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Input url file
$InputUrl = "https://www.wikipedia.org"

# Result file name
$ResultFile = ".\result.png"

$resultFileName = [System.IO.Path]::GetFileName($ResultFile)
$query = "https://api.pdf.co/v1/url/convert/to/png?name=$($resultFileName)&url=$($InputUrl)"
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Get URL of Generated output image file
        $resultFileUrl = $jsonResponse.url
        
        # Download the image file
        Invoke-WebRequest -Uri $resultFileUrl -OutFile $ResultFile

        Write-Host "Generated output saved to '$($ResultFile)' file."
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