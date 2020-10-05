curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/delete-text' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf' \
--form 'name=pdfWithTextDeleted' \
--form 'caseSensitive=false' \
--form 'searchString=conspicuous feature'