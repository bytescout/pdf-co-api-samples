curl --location --request POST 'https://api.pdf.co/v1/pdf/split2' \
--header 'Content-Type: application/json' \
--header 'x-api-key: ADD_YOUR_API_KEY_HERE' \
--data-raw '{
    "url": "https://bytescout-com.s3.us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-split/split_by_barcode.pdf",
    "searchString": "[[barcode:qrcode,datamatrix /bytescout\\.com/]]",
    "excludeKeyPages": true,
    "regexSearch": false,
    "caseSensitive": false,
    "inline": true,
    "name": "output-split-by-barcode",
    "async": false
}'