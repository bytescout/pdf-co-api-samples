curl --location --request POST 'https://api.pdf.co/v1/pdf/find/table' \
--header 'x-api-key: your_pdfco_api_key' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf",
    "async": "false",
    "encrypt": "false",
    "inline": "true",
    "password": ""
}'