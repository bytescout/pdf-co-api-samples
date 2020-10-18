import requests

url = "https://api.pdf.co/v1/file/upload"

payload = {}
files = [
		('file', open('/path/to/file','rb'))
]
headers = {
		'x-api-key': '{{x-api-key}}'
}

response = requests.request("POST", url, headers=headers, data = payload, files = files)

print(response.text.encode('utf8'))
