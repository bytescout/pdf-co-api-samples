curl --location --request POST 'https://api.pdf.co/v1/barcode/generate' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'name=barcode.png' \
--form 'value=abcdef123456' \
--form 'type=QRCode' \
--form 'decorationImage=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/barcode-generator/logo.png'