import requests

url = "https://api.pdf.co/v1/file/hash"

# You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
payload = "{\n    \"url\": \"https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf\"\n}"
headers = {
		'x-api-key': '{{x-api-key}}',
		'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data = payload)

print(response.text.encode('utf8'))
