curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/from/email' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml",
    "embedAttachments": true,
    "name": "email-with-attachments",
    "async": false,
    "encrypt": false,
    "profiles": "{\"orientation\": \"landscape\", \"paperSize\": \"letter\" }"
}'