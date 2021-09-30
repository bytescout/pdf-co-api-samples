curl --location --request POST 'https://api.pdf.co/v1/pdf/convert/from/html' \
--header 'x-api-key: {{x-api-key}}' \
--form 'html=<h1>Hello World!</h1>' \
--form 'name=result.pdf'