curl --location --request POST 'https://api.pdf.co/v1/pdf/split' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf' \
--form 'name=result.pdf' \
--form 'pages=1-2,3-'