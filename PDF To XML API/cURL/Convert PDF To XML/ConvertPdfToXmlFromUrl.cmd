curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/xml' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-xml/sample.pdf' \
--form 'name=result.xml' \
--form 'password=' \
--form 'pages='