import requests

url = "https://api.pdf.co/v1/pdf/convert/from/email"

# You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
payload="{\n    \"url\": \"https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml\",\n    \"embedAttachments\": true,\n    \"name\": \"email-with-attachments\",\n    \"async\": false,\n    \"encrypt\": false,\n    \"profiles\": \"{\\\"orientation\\\": \\\"landscape\\\", \\\"paperSize\\\": \\\"letter\\\" }\"\n}"
headers = {
		'Content-Type': 'application/json',
		'x-api-key': '{{x-api-key}}'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)
