curl --location 'https://api.pdf.co/v1/ai-invoice-parser' \
--header 'x-api-key: YOUR_PDFco_API_HERE' \
--header 'Content-Type: application/json' \
--data '{
    "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/document-parser/sample-invoice.pdf"
}'