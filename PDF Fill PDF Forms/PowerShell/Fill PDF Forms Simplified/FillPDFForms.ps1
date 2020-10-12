$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("x-api-key", "{{x-api-key}}")

$body = "{`n    `"async`": false,`n    `"encrypt`": false,`n    `"name`": `"f1040-form-filled`",`n    `"url`": `"bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-form/f1040.pdf`",`n    `"fieldsString`": `"1;topmostSubform[0].Page1[0].f1_02[0];John A. Doe|1;topmostSubform[0].Page1[0].FilingStatus[0].c1_01[1];true|1;topmostSubform[0].Page1[0].YourSocial_ReadOrderControl[0].f1_04[0];123456789`"`n}"

$response = Invoke-RestMethod 'https://api.pdf.co/v1/pdf/edit/add' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json