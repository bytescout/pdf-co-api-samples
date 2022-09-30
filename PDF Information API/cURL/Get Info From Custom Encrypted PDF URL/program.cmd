curl --location --request POST 'https://api.pdf.co/v1/pdf/info' \
--header 'x-api-key: YOUR_PDF_CO_API_KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/encryption/sample_encrypted_aes128.pdf",
    "async": false,
    "profiles": "{ '\''DataDecryptionAlgorithm'\'': '\''AES128'\'', '\''DataDecryptionKey'\'': '\''HelloThisKey1234'\'', '\''DataDecryptionIV'\'': '\''TreloThisKey1234'\'' }"
}'