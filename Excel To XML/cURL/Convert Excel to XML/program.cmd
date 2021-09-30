curl --location --request POST 'https://api.pdf.co/v1/xls/convert/to/xml' \
--header 'x-api-key: your_pdfco_api_key' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/other/Input.xls"
}'