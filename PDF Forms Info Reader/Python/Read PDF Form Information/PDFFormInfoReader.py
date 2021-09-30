import requests

url = "https://api.pdf.co/v1/pdf/info/fields"

# You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
payload = {'url': 'https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-form/f1040.pdf'}
files = [

]
headers = {
		'x-api-key': '{{x-api-key}}'
}

response = requests.request("POST", url, headers=headers, data = payload, files = files)

print(response.text.encode('utf8'))
