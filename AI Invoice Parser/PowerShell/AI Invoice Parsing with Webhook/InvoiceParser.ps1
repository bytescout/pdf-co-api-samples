$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("x-api-key", "YOUR_PDFco_API_HERE")
$headers.Add("Content-Type", "application/json")

$body = @"
{
    `"url`": `"https://pdfco-test-files.s3.us-west-2.amazonaws.com/document-parser/sample-invoice.pdf`",
    `"callback`": `"https://example.com/callback/url/you/provided`"
}
"@

$response = Invoke-RestMethod 'https://api.pdf.co/v1/ai-invoice-parser' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json