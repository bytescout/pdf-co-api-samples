import os
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "***********************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# --HTML Template ID--
# Please follow below steps to create your own HTML Template and get "templateId". 
# 1. Add new html template in app.pdf.co/templates/html
# 2. Copy paste your html template code into this new template. Sample HTML templates can be found at "https://github.com/bytescout/pdf-co-api-samples/tree/master/PDF%20from%20HTML%20template/TEMPLATES-SAMPLES"
# 3. Save this new template
# 4. Copy it’s ID to clipboard
# 5. Now set ID of the template into “templateId” parameter

# HTML template using built-in template
# see https://app.pdf.co/templates/html/2/edit
template_id = 2


# Data to fill the template
file_read = open(".\\invoice_data.json", mode='r')
TemplateData = file_read.read()
file_read.close()

# Destination PDF file name
DestinationFile = ".\\result.pdf"


def main(args = None):
    GeneratePDFFromTemplate(template_id, TemplateData, DestinationFile)


def GeneratePDFFromTemplate(template_id, templateData, destinationFile):
    """Converts HTML to PDF using PDF.co Web API"""

    data = {
        'templateData': templateData,
        'templateId': template_id
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