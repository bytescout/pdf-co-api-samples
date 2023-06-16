import requests
import os

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "***************************************"

# Direct URL of source PDF file.
SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf"

# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
Pages = ""

# PDF document password. Leave empty for unprotected documents.
Password = ""

# Prepare URL for PDF Table Search API call.
query = "https://api.pdf.co/v1/pdf/find/table"
reqOptions = {
    'password': Password,
    'pages': Pages,
    'url': SourceFileUrl
}
headers = {
    'x-api-key': API_KEY
}


def getJSONFromCoordinates(fileUrl, pageIndex, rect, outputFileName):
    # Prepare request to `PDF To JSON` API endpoint
    jsonQueryPath = "https://api.pdf.co/v1/pdf/convert/to/json"

    # Json Request
    jsonReqOptions = {
        'pages': pageIndex,
        'url': fileUrl,
        'rect': rect
    }

    # Send request
    response = requests.post(jsonQueryPath, headers=headers, data=jsonReqOptions)
    if response.status_code == 200:
        outputJsonUrl = response.json()['url']

        # Download JSON file
        res = requests.get(outputJsonUrl)
        with open(outputFileName, 'wb') as outfile:
            outfile.write(res.content)
        print(f'Generated JSON file saved as "{outputFileName}" file.')
    else:
        print(f"Request error: {response.status_code} {response.reason}")


# Send request
response = requests.post(query, headers=headers, data=reqOptions)
if response.status_code == 200:
    jsonBody = response.json()

    # Loop through all found tables, and get json data
    if 'tables' in jsonBody['body'] and len(jsonBody['body']['tables']) > 0:
        for i, table in enumerate(jsonBody['body']['tables']):
            getJSONFromCoordinates(SourceFileUrl, table['PageIndex'], table['rect'], f"table_{i + 1}.json")
else:
    print(f"Request error: {response.status_code} {response.reason}")

