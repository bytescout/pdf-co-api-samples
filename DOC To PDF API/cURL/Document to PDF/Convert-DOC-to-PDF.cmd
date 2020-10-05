curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/from/doc' \
--header 'x-api-key: {{x-api-key}}' \
--form 'encrypt=true' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/doc-to-pdf/sample.docx' \
--form 'name=result.pdf'