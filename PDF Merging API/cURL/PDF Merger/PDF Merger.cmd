curl --location --request POST 'https://api.pdf.co/v1/pdf/merge' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf,https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample2.pdf' \
--form 'name=result.pdf'