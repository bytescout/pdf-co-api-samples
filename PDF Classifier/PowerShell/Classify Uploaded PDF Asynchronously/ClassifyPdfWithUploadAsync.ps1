$APIBaseURL='https://api.pdf.co/v1'

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$InputFile = "$scriptDir\sample.pdf"

$RulesSpreadsheet = "$scriptDir\rules.csv"
$RulesColumnIndex = 1
$ResultIdentifiersColumnIndex = 0

function main() 
{
    $rules = Get-Content -Path $RulesSpreadsheet | Out-String

    Write-Host "Uploading document `"$InputFile`"" -ForegroundColor Green
    $fileUrl = UploadFile $InputFile
    
    if ($null -ne $fileUrl) {
        Write-Host "Processing document..."
        $result = ClassifyDocument $fileUrl $rules
        if ($null -ne $result) {
            Write-Host "Detected classes:"
            foreach ($elem in $result.classes) {
                Write-Host $elem.class
            }
        }
    }
}

function ClassifyDocument($fileUrl, $rules)
{
    # Prepare URL for `pdf/classifier` API call
    $query = "$APIBaseURL/pdf/classifier"
    # Prepare POST request body
    $body = @{
        "async" = "true";
        "url" = $fileUrl;
        "rulescsv" = $rules;
        "caseSensitive" = $false
    } | ConvertTo-Json

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("x-api-key", "")

    # Note, rules can also be passed as URL of file `rulesCsvUrl` param instead of `rulesCsv`.
    # Rules can be a spreadhset in CSV, XLS, XLSX, ODS format.

    try {
        # Execute request
        $jsonResponse = Invoke-RestMethod -Method Post -Uri $query -Body $body -Headers $headers

        if ($jsonResponse.error -eq $false) {
            # Asynchronous job ID
            $jobId = $jsonResponse.jobId
            # URL of generated TXT file that will available after the job completion
            $resultFileUrl = $jsonResponse.url

            # Check the job status in a loop. 
            do {
                $statusCheckUrl = "{0}/job/check?jobid={1}" -f $APIBaseURL, $jobId
                $jsonStatus = Invoke-RestMethod -Method Get -Uri $statusCheckUrl -Headers $headers

                # Display timestamp and status (for demo purposes)
                Write-Host "$(Get-date): $($jsonStatus.status)"

                if ($jsonStatus.status -eq "success") {
                    # Download result
                    return Invoke-WebRequest -Uri $resultFileUrl | ConvertFrom-Json
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
        # Display exception if any
        Write-Host $_.Exception
    }

    return $null
}

function UploadFile($filePath)
{
    # Prepare URL for `Get Presigned URL` API call
    $query = "{0}/file/upload/get-presigned-url?contenttype=application/octet-stream&name={1}" -f `
        $APIBaseURL, [System.IO.Path]::GetFileName($filePath)
    $query = [System.Uri]::EscapeUriString($query)

    try {
        # Execute request
        $jsonResponse = Invoke-RestMethod -Method Get  -Uri $query
        
        if ($jsonResponse.error -eq $false) {
            # Get URL to use for the file upload
            $uploadUrl = $jsonResponse.presignedUrl
            # Get URL of uploaded file to use with later API calls
            $uploadedFileUrl = $jsonResponse.url
    
            # UPLOAD THE FILE
            $r = Invoke-WebRequest -Method Put -Headers @{ "content-type" = "application/octet-stream" } -InFile $filePath -Uri $uploadUrl
            
            if ($r.StatusCode -eq 200) {
                return $uploadedFileUrl
            }
            else {
                # Display request error status
                Write-Host $r.StatusCode + " " + $r.StatusDescription
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

    return $null;
}

main

trap {
    Write-Host "Exception: $_" -ForegroundColor White -BackgroundColor DarkRed
    exit 1
}

