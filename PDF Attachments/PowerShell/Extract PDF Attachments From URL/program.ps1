$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("x-api-key", "__Replace_With_Your_PDFco_API_Key__")

$body = "{`n    `"url`": `"https://bytescout-com.s3.us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-attachments/attachments.pdf`",`n    `"inline`": true,`n    `"async`": false`n}"

$response = Invoke-RestMethod 'https://api.pdf.co/v1/pdf/attachments/extract' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json