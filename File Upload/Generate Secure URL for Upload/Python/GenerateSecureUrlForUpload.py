import requests

url = "https://api.pdf.co/v1/file/upload/get-presigned-url?name=test.pdf&encrypt=true"

payload = {}
files = {}
headers = {
		'x-api-key': '{{x-api-key}}'
}

response = requests.request("GET", url, headers=headers, data = payload, files = files)

print(response.text.encode('utf8'))
