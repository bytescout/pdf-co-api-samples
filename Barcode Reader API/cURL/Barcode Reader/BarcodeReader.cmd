curl --location --request POST 'https://api.pdf.co/v1/barcode/read/from/url' \
--header 'x-api-key: YOUR_API_KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf",
    "types": "QRCode,Code128,Code39,Interleaved2of5,EAN13",
    "pages": "0",
    "encrypt": false,
    "async": false
}'
