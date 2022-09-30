curl --location --request POST 'https://api.pdf.co/v1/barcode/read/from/url' \
--header 'x-api-key: PDF_CO_API_KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/encryption/barcode_encrypted_aes128.png",
	"types": "QRCode",
	"inline": true,
    "async": false,
	"profiles": "{ '\''DataDecryptionAlgorithm'\'': '\''AES128'\'', '\''DataDecryptionKey'\'': '\''Qweasd1234567890'\'', '\''DataDecryptionIV'\'': '\''0mDI&qLv*ivTCd$*'\'' }"
}'