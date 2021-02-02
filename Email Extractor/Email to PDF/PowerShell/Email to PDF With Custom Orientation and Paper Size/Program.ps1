$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("x-api-key", "{{x-api-key}}")

$body = "{`n    `"url`": `"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml`",`n    `"embedAttachments`": true,`n    `"name`": `"email-with-attachments`",`n    `"async`": false,`n    `"encrypt`": false,`n    `"profiles`": `"{`\`"orientation`\`": `\`"landscape`\`", `\`"paperSize`\`": `\`"letter`\`" }`"`n}"

$response = Invoke-RestMethod 'https://api.pdf.co/v1/pdf/convert/from/email' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json