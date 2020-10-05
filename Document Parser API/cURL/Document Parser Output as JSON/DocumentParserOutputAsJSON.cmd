curl --location --request POST 'https://api.pdf.co/v1/pdf/documentparser' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf",
    "outputFormat": "JSON",
    "templateId": "1",
    "async": false,
    "encrypt": "false",
    "inline": "true",
    "password": "",
    "profiles": "",
    "storeResult": false
}'