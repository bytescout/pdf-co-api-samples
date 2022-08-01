$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("x-api-key", "YOUR_PDFCO_API_KEY")

$body = "{`n    `"url`": `"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf`",`n    `"async`": false,`n    `"encrypt`": `"false`",`n    `"inline`": `"true`",`n    `"password`": `"`",`n    `"profiles`": `"`"`n} "

$response = Invoke-RestMethod 'https://api.pdf.co/v1/pdf/classifier' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json