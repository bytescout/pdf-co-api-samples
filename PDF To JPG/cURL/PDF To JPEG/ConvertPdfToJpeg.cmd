curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/jpg' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf' \
--form 'password=' \
--form 'pages='