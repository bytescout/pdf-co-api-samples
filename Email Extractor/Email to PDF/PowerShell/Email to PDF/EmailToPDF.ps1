$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("x-api-key", "{{x-api-key}}")

$multipartContent = [System.Net.Http.MultipartFormDataContent]::new()
$stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$stringHeader.Name = "url"
$stringContent = [System.Net.Http.StringContent]::new("https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml")
$stringContent.Headers.ContentDisposition = $stringHeader
$multipartContent.Add($stringContent)

$stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$stringHeader.Name = "embedAttachments"
$stringContent = [System.Net.Http.StringContent]::new("true")
$stringContent.Headers.ContentDisposition = $stringHeader
$multipartContent.Add($stringContent)

$stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$stringHeader.Name = "convertAttachments"
$stringContent = [System.Net.Http.StringContent]::new("true")
$stringContent.Headers.ContentDisposition = $stringHeader
$multipartContent.Add($stringContent)

$stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$stringHeader.Name = "paperSize"
$stringContent = [System.Net.Http.StringContent]::new("Letter")
$stringContent.Headers.ContentDisposition = $stringHeader
$multipartContent.Add($stringContent)

$stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$stringHeader.Name = "name"
$stringContent = [System.Net.Http.StringContent]::new("email-with-attachments")
$stringContent.Headers.ContentDisposition = $stringHeader
$multipartContent.Add($stringContent)

$stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$stringHeader.Name = "async"
$stringContent = [System.Net.Http.StringContent]::new("false")
$stringContent.Headers.ContentDisposition = $stringHeader
$multipartContent.Add($stringContent)

$body = $multipartContent

$response = Invoke-RestMethod 'https://api.pdf.co/v1/pdf/convert/from/email' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json