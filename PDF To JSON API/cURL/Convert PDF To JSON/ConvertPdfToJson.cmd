curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'inline=true' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf'