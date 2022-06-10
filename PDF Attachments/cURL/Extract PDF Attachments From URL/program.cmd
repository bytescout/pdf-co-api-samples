curl --location --request POST 'https://api.pdf.co/v1/pdf/attachments/extract' \
--header 'Content-Type: application/json' \
--header 'x-api-key: __Replace_With_Your_PDFco_API_Key__' \
--data-raw '{
    "url": "https://bytescout-com.s3.us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-attachments/attachments.pdf",
    "inline": true,
    "async": false
}'