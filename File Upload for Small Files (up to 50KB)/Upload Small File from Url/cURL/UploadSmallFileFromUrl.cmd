curl --location --request POST 'https://api.pdf.co/v1/file/upload/url' \
--header 'x-api-key: {{x-api-key}}' \
--form 'name=sample.pdf' \
--form 'url=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf'