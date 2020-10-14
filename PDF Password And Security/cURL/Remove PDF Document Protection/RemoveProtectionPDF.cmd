curl --location --request POST 'https://api.pdf.co/v1/pdf/security/remove' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url=https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-security/ProtectedPDFFile.pdf' \
--form 'password=admin@123' \
--form 'name=unprotected'