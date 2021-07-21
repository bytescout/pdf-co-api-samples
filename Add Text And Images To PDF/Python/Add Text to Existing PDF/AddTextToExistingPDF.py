import os
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
API_KEY = "******************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of source PDF file.
# You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

#Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
Pages = ""

# PDF document password. Leave empty for unprotected documents.
Password = ""

# Destination PDF file name
DestinationFile = ".//result.pdf"

# Text annotation params
Type = "annotation"
X = 400
Y = 600
Text = "APPROVED"
FontName = "Times New Roman"
FontSize = 24
Color = "FF0000"


def main(args = None):
    addTextToExistingPDF(DestinationFile)

def addTextToExistingPDF(destinationFile):
    """Add Text using PDF.co Web API"""

    # Prepare requests params as JSON
    # See documentation: https://apidocs.pdf.co
    parameters = {}
    parameters["name"] = os.path.basename(destinationFile)
    parameters["password"] = Password
    parameters["pages"] = Pages
    parameters["url"] = SourceFileUrl
    parameters["type"] = Type
    parameters["x"] = X
    parameters["y"] = Y
    parameters["text"] = Text
    parameters["fontname"] = FontName
    parameters["size"] = FontSize
    parameters["color"] = Color

    # Prepare URL for 'PDF Edit' API request
    url = "{}/pdf/edit/add".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, data=parameters, headers={ "x-api-key": API_KEY })
    if (response.status_code == 200):
        json = response.json()

        if json["error"] == False:
            #  Get URL of result file
            resultFileUrl = json["url"]            
            # Download result file
            r = requests.get(resultFileUrl, stream=True)
            if (r.status_code == 200):
                with open(destinationFile, 'wb') as file:
                    for chunk in r:
                        file.write(chunk)
                print(f"Result file saved as \"{destinationFile}\" file.")
            else:
                print(f"Request error: {response.status_code} {response.reason}")
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

if __name__ == '__main__':
    main()