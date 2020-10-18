$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("x-api-key", "{{x-api-key}}")

$multipartContent = [System.Net.Http.MultipartFormDataContent]::new()
$body = $multipartContent

$response = Invoke-RestMethod 'https://api.pdf.co/v1/file/upload/get-presigned-url?name=test.pdf&encrypt=true' -Method 'GET' -Headers $headers -Body $body
$response | ConvertTo-Json