curl --location --request POST 'https://api.pdf.co/v1/pdf/info' \
--header 'x-api-key: {{x-api-key}}' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf"
}'