## How to generate PDF invoice from HTML template for HTML to PDF API in Python and PDF.co Web API

### Step-by-step tutorial:How to generate PDF invoice from HTML template to have HTML to PDF API in Python

Check these thousands of pre-made source code samples for simple implementation in your own programming projects. HTML to PDF API in Python can be applied with PDF.co Web API. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

Want to learn quickly? These fast application programming interfaces of PDF.co Web API for Python plus the instruction and the code below will help to learn how to generate PDF invoice from HTML template. For implementation of this functionality, please copy and paste the code below into your app using code editor. Then compile and run your app. Enjoy writing a code with ready-to-use sample Python codes to add HTML to PDF API functions using PDF.co Web API in Python.

Trial version of ByteScout is available for free download from our website. This and other source code samples for Python and other programming languages are available.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore Documentation](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Explore Source Code Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://app.pdf.co/signup?utm_source=github-readme)
[Security](https://pdf.co/security)
[Explore Web API Documentation](https://apidocs.pdf.co?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### **GeneratePdfInvoiceFromHtmlTemplate.py:**
    
```
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
```

<!-- code block end -->    

<!-- code block begin -->

##### **invoice_data.json:**
    
```
{
    "number": "1234567",
    "date": "April 30, 2016",
    "from": "Acme Inc., City, Street 3rd , +1 888 123-456, support@example.com",
    "to": "Food Delivery Inc., New York, Some Street, 42",
    "lines": [{
        "title": "Setting up new web-site",
        "quantity": 3,
        "price": 50
    }, {
        "title": "Configuring mail server and mailboxes",
        "quantity": 5,
        "price": 50
    }]
}
```

<!-- code block end -->