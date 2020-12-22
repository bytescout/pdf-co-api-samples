curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/from/email' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--form 'url="https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml"' \
--form 'embedAttachments="true"' \
--form 'convertAttachments="true"' \
--form 'paperSize="Letter"' \
--form 'name="email-with-attachments"' \
--form 'async="false"'