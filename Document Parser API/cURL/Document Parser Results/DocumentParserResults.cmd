curl --location --request POST 'https://api.pdf.co/v1/pdf/documentparser/results' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
    "fileUrl": "https://github.com/bytescout/ByteScout-SDK-SourceCode/raw/master/Document%20Parser%20SDK/DigitalOcean.pdf",
    "templateId": 48,
    "formatType": "CSV",
    "result": "companyName,companyName2,invoiceId,dateIssued,dateDue,total,subTotal,tax\r\n,,,,,450.00,,\r\n\r\n"
}'