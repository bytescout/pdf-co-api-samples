curl --location --request POST 'https://api.pdf.co/v1/email/send' \
--header 'Content-Type: application/json' \
--header 'x-api-key: Your_PDF_co_API_Here' \
--data-raw '{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf",
    "from": "John Doe <john@example.com>",
    "to": "Partner <partner@example.com>",
    "subject": "Check attached sample pdf",
    "bodytext": "Please check the attached pdf",
    "bodyHtml": "Please check the attached pdf",
    "smtpserver": "smtp.gmail.com",
    "smtpport": "587",
    "smtpusername": "my@gmail.com", 
    "smtppassword": "app specific password created as https://support.google.com/accounts/answer/185833",
    "async": false
}'