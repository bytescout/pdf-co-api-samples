import os
import  json
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
API_KEY = "***********************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# HTML template
file_read = open(".\\invoice_template.html", mode='r')
Template = file_read.read()
file_read.close()

# Data to fill the template
file_read = open(".\\invoice_data.json", mode='r')
TemplateData = json.dumps(file_read.read())
file_read.close()

# Destination PDF file name
DestinationFile = ".\\result.pdf"


def main(args = None):
    GeneratePDFFromTemplate(Template, TemplateData, DestinationFile)


def GeneratePDFFromTemplate(template, templateData, destinationFile):
    """Converts HTML to PDF using PDF.co Web API"""

    data = {
        'templateData': templateData,
        'html': template
    }

    # Prepare URL for 'HTML To PDF' API request
    url = "{}/pdf/convert/from/html?name={}".format(
        BASE_URL,
        os.path.basename(destinationFile)
    )

    # Execute request and get response as JSON

    response = requests.post(url, data=data, headers={ "x-api-key": API_KEY })
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