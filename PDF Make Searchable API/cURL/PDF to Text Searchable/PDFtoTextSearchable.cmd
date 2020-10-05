curl --location --request POST 'https://api.pdf.co/v1/pdf/makesearchable' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-make-searchable/sample.pdf' \
--form 'name=result.pdf' \
--form 'password=' \
--form 'pages='