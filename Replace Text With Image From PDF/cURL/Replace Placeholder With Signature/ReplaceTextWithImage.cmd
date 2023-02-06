curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/replace-text-with-image' \
--header 'x-api-key: AddYourPdfCoApiKeyHere' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-search-and-replace/sample-agreement-template-signature-page-2.pdf",
    "caseSensitive": "true",
    "searchString": "[CLIENT-SIGNATURE]",
    "replaceImage": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-search-and-replace/john-doe-signature-image.png",
    "pages": "0",
    "async": false
}'