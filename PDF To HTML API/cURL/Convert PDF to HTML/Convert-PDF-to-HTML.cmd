curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/html' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-html/sample.pdf' \
--form 'name=result.html' \
--form 'password=' \
--form 'simple=false' \
--form 'columns=false'