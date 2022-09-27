curl --location --request POST 'https://api.pdf.co/v1/pdf/optimize' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-optimize/sample.pdf",
    "profiles": "{ '\''ImageOptimizationFormat'\'': '\''JPEG'\'', '\''JPEGQuality'\'': 25, '\''ResampleImages'\'': true, '\''ResamplingResolution'\'': 120, '\''GrayscaleImages'\'': false }",
    "async": false
}'