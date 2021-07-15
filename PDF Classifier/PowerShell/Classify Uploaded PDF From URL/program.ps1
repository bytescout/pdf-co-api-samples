$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("x-api-key", "")

$body = "{`n    `"url`": `"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf`",`n    `"rulescsv`": `"Amazon,Amazon Web Services Invoice|Amazon CloudFront`\nDigital Ocean,DigitalOcean|DOInvoice`\nAcme,ACME Inc.|1540 Long Street, Jacksonville, 32099`",`n    `"caseSensitive`": `"true`",`n    `"async`": false,`n    `"encrypt`": `"false`",`n    `"inline`": `"true`",`n    `"password`": `"`",`n    `"profiles`": `"`"`n} "

$response = Invoke-RestMethod 'https://api.pdf.co/v1/pdf/classifier' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
