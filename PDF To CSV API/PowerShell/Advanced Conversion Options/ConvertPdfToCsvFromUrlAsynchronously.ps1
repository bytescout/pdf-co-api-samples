# Cloud API asynchronous "PDF To CSV" job example.
# Allows to avoid timeout errors when processing huge or scanned PDF documents.

# (!) If you are getting '(403) Forbidden' error please ensure you have set the correct API_KEY

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "***********************************"

# Direct URL of source PDF file.
$SourceFileUrl = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/pdf-to-csv/sample.pdf"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""
# PDF document password. Leave empty for unprotected documents.
$Password = ""
# Destination CSV file name
$DestinationFile = ".\result.csv"
# (!) Make asynchronous job
$Async = $true

# Sample profile that sets advanced conversion options
# Advanced options are properties of CSVExtractor class from ByteScout PDF Extractor SDK used in the back-end:
# https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/87ce5fa6-3143-167d-abbd-bc7b5e160fe5.htm
$Profiles = '{ "profiles": [{ "profile1": { "OCRMode": "TextFromImagesAndVectorsAndFonts", "CSVSeparatorSymbol": "," } } ] }'

# Prepare URL for `PDF To CSV` API call
$query = "https://api.pdf.co/v1/pdf/convert/to/csv?name={0}&password={1}&pages={2}&url={3}&async={4}&profiles={5}" -f `
    $(Split-Path $DestinationFile -Leaf), $Password, $Pages, $SourceFileUrl, $Async, $Profiles
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

    if ($jsonResponse.error -eq $false) {
        # Asynchronous job ID
        $jobId = $jsonResponse.jobId
        # URL of generated CSV file that will available after the job completion
        $resultFileUrl = $jsonResponse.url

        # Check the job status in a loop. 
        do {
            $statusCheckUrl = "https://api.pdf.co/v1/job/check?jobid=" + $jobId
            $jsonStatus = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $statusCheckUrl

            # Display timestamp and status (for demo purposes)
            Write-Host "$(Get-date): $($jsonStatus.status)"

            if ($jsonStatus.status -eq "success") {
                # Download CSV file
                Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $DestinationFile -Uri $resultFileUrl
                Write-Host "Generated CSV file saved as `"$($DestinationFile)`" file."
                break
            }
            elseif ($jsonStatus.status -eq "working") {
                # Pause for a few seconds
                Start-Sleep -Seconds 3
            }
            else {
                Write-Host $jsonStatus.status
                break
            }
        }
        while ($true)
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
