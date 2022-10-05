curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/rotate/auto' \
--header 'x-api-key: YOUR_PDF_CO_API_KEY_HERE' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-fix-rotation/rotated_pages.pdf",
    "name": "result.pdf"
}'