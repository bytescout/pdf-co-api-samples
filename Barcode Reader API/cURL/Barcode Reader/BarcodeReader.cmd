curl --location --request POST 'https://api.pdf.co/v1/barcode/read/from/url' \
--header 'x-api-key: {{x-api-key}}' \
--form 'types=Code128,Code39,Interleaved2of5,EAN13' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf' \
--form 'pages='