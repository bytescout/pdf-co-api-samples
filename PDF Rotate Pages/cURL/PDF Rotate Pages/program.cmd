curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/rotate' \
--header 'x-api-key: YOUR_PDF_CO_API_KEY_HERE' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-optimize/sample.pdf",
    "name": "result.pdf",
    "angle": 90,
    "pages": "0-2,4"
}'