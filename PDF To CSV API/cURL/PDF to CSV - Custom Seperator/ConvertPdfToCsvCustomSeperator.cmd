curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/to/csv' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-csv/sample.pdf' \
--form 'name=result.csv' \
--form 'password=' \
--form 'pages=' \
--form 'profiles={ '\''profiles'\'': [ { '\''profile1'\'': { '\''CSVSeparatorSymbol'\'': '\'';'\'' } } ] }'