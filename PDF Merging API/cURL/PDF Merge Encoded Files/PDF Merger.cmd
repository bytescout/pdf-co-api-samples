curl --location --request POST 'https://api.pdf.co/v1/pdf/merge' \
--header 'x-api-key: YOUR_PDFco_API_KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/encryption/sample_encrypted_aes128.pdf, https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/encryption/sample_encrypted_aes128.pdf",
    "name": "result.pdf",
    "pages": "0",
    "async": false,
    "profiles": "{ '\''DataDecryptionAlgorithm'\'': '\''AES128'\'', '\''DataDecryptionKey'\'': '\''HelloThisKey1234'\'', '\''DataDecryptionIV'\'': '\''TreloThisKey1234'\'' }"
}'