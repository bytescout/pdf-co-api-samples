import requests

url = "https://api.pdf.co/v1/pdf/convert/from/email"

payload={'url': 'https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml',
'embedAttachments': 'true',
'convertAttachments': 'true',
'paperSize': 'Letter',
'name': 'email-with-attachments',
'async': 'false'}
files=[

]
headers = {
		'Content-Type': 'application/json',
		'x-api-key': '{{x-api-key}}'
}

response = requests.request("POST", url, headers=headers, data=payload, files=files)

print(response.text)
