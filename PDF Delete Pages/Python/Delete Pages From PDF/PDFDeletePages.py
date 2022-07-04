import requests

url = "https://api.pdf.co/v1/pdf/edit/delete-pages"

# You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
payload = {'url': 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf',
'name': 'result.pdf',
'pages': '1-2'}
files = [

]
headers = {
		'x-api-key': '{{x-api-key}}'
}

response = requests.request("POST", url, headers=headers, json = payload, files = files)

print(response.text.encode('utf8'))
