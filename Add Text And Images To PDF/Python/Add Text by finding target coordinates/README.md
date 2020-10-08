## How to add text and images to PDF in Python and PDF.co Web API

### How to write a robust code in Python to add text and images to PDF with this step-by-step tutorial

An easy to understand sample source code to learn how to add text and images to PDF in Python PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf. It can be applied to add text and images to PDF using Python.

The SDK samples given below describe how to quickly make your application do add text and images to PDF in Python with the help of PDF.co Web API. Follow the instructions from scratch to work and copy the Python code. Complete and detailed tutorials and documentation are available along with installed PDF.co Web API if you'd like to learn more about the topic and the details of the API.

You can download free trial version of PDF.co Web API from our website with this and other source code samples for Python.

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

##### **AddTextByFindingTargetCoordinates.py:**
    
```
import os
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
API_KEY = "******************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of source PDF file.
SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

# Search string.
SearchString = 'Notes'

# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
Pages = ""

# PDF document password. Leave empty for unprotected documents.
Password = ""

# Destination PDF file name
DestinationFile = ".//result.pdf"

# Text annotation params
Type = "annotation"
Text = "Some notes will go here... Some notes will go here.... Some notes will go here....."
FontName = "Times New Roman"
FontSize = 12
Color = "FF0000"


def main(args = None):
    # First of all try to find Text within input PDF file
    res = findTextWithinPDF(SourceFileUrl, SearchString)

    if res:
        addImageToPDF(DestinationFile, res['top'], res['left'])
    else:
        print("No result found!")


def findTextWithinPDF(sourceFile, searchText):
    # Prepare URL for PDF text search API call
    # See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html

    retVal = dict()

    # Prepare requests params as JSON
    # See documentation: https://apidocs.pdf.co
    parameters = {}
    parameters["url"] = sourceFile
    parameters["searchString"] = searchText


    url = "{}/pdf/find".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, data=parameters, headers={ "x-api-key": API_KEY })
    if (response.status_code == 200):
        json = response.json()

        if json["error"] == False:
            # print(json)
            if json["body"]:
                retVal['top'] = json["body"][0]['top']
                retVal['left'] = json["body"][0]['left']
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return retVal



def addImageToPDF(destinationFile, top, left):
    """Add text using PDF.co Web API"""

    # Prepare requests params as JSON
    # See documentation: https://apidocs.pdf.co
    parameters = {}
    parameters["name"] = os.path.basename(destinationFile)
    parameters["password"] = Password
    parameters["pages"] = Pages
    parameters["url"] = SourceFileUrl
    parameters["type"] = Type
    parameters["x"] = left
    parameters["y"] = top + 25
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
            with open(destinationFile, 'wb') as file:
                for chunk in r:
                    file.write(chunk)
            print(f"Result file saved as \"{destinationFile}\" file.")
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

if __name__ == '__main__':
    main()
```

<!-- code block end -->