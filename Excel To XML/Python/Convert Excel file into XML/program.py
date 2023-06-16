import os
import requests  # pip install requests
import json

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "***************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of source xls file.
SourceFileURL = "https://pdfco-test-files.s3.us-west-2.amazonaws.com/other/Input.xls"

def main(args = None):
    convertXlsToXml(SourceFileURL)

def convertXlsToXml(sourceFileUrl):
    """Convert Xls/Xlsx to Xml using PDF.co Web API"""

    # Prepare requests params as JSON
    parameters = {
        "url": sourceFileUrl,
        "async": False
    }

    # Prepare URL for 'Xls to Xml' API request
    url = "{}/xls/convert/to/xml".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, headers={ "x-api-key": API_KEY, "Content-Type": "application/json" }, data=json.dumps(parameters))
    if (response.status_code == 200):
        json_res = response.json()

        if json_res["error"] == False:
            # Get URL of result file
            resultFileUrl = json_res["url"]
            # Output URL of converted xml file
            print(f"Result file url: {resultFileUrl}")
        else:
            # Show service reported error
            print(json_res["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

if __name__ == '__main__':
    main()
