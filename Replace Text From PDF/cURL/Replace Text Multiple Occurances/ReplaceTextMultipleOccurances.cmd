curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/replace-text' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
  "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf",
  "searchStrings": [
     "Your Company Name",
    "Client Name"
  ],
  "replaceStrings": [
    "XYZ LLC",
    "ABCD"
  ],
  "caseSensitive": true,
  "pages": "",
  "password":"",
  "name": "finalFile"
  
}'