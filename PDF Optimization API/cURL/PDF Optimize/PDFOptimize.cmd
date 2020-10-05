curl --location --request POST 'https://api.pdf.co/v1/pdf/optimize' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-optimize/sample.pdf' \
--form 'name=result.pdf' \
--form 'password='