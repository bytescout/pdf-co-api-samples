curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/text' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf' \
--form 'name=result.txt' \
--form 'password=' \
--form 'pages='