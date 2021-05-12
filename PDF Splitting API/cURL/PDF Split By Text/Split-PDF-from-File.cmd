curl --location --request POST 'https://api.pdf.co/v1/pdf/split2' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-split/multiple-invoices.pdf' \
--form 'name=result.pdf' \
--form 'searchString=invoice number'