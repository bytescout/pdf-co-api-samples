import requests
import json

# Your API endpoint URL.
url = "https://api.pdf.co/v1/xls/convert/to/csv"

# Your API Key.
api_key = "Your API Key"

# The URL of the Excel file you want to convert.
input_file_url = "https://pdfco-test-files.s3.us-west-2.amazonaws.com/other/Input.xls"

headers = {
    "x-api-key": api_key,
    "Content-Type": "application/json"
}

data = {
    "url": input_file_url,
    "async": False
}

response = requests.post(url, headers=headers, json=data)

if response.status_code == 200:
    # The request was successful.
    # Parse the json response.
    data = response.json()

    # Extract the CSV file URL from the response.
    csv_url = data.get('url', '')
    print("CSV file is available at: ", csv_url)
else:
    # There was an error with the request.
    print("Error: ", response.status_code)
