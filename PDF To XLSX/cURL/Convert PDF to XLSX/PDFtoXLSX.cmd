curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/xlsx?=' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-excel/sample.pdf' \
--form 'name=result.xlsx' \
--form 'password=' \
--form 'pages='