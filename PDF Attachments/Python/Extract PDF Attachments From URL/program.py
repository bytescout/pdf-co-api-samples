import requests
import json

url = "https://api.pdf.co/v1/pdf/attachments/extract"

payload = json.dumps({
  "url": "https://bytescout-com.s3.us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-attachments/attachments.pdf",
  "inline": True,
  "async": False
})
headers = {
		'Content-Type': 'application/json',
		'x-api-key': '__Replace_With_Your_PDFco_API_Key__'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)
