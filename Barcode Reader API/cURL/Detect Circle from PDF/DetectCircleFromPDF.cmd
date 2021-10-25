curl --location --request POST 'https://api.pdf.co/v1/barcode/read/from/url' \
--header 'x-api-key: {{x-api-key}}' \
--header 'Content-Type: application/json' \
--data-raw '{
    "types": "Circle",
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-form/f1040.pdf",
    "pages": ""
}'