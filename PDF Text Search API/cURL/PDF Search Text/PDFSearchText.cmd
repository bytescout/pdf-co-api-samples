curl --location --request POST 'https://api.pdf.co/v1/pdf/find' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf' \
--form 'searchString=Invoice Date \d+/\d+/\d+' \
--form 'pages=' \
--form 'password=' \
--form 'regexSearch=true'