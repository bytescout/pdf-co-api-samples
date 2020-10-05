curl --location --request POST 'https://api.pdf.co/v1/xls/convert/to/csv' \
--header 'x-api-key: {{x-api-key}}' \
--form 'encrypt=true' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/other/Input.xls' \
--form 'inline=true'