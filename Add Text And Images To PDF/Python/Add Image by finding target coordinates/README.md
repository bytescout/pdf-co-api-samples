## How to add text and images to PDF in Python using PDF.co Web API

### Learning is essential in computer world and the tutorial below will demonstrate how to add text and images to PDF in Python

On this page you will learn from code samples for programming in Python.Writing of the code to add text and images to PDF in Python can be executed by programmers of any level using PDF.co Web API. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf. It can be applied to add text and images to PDF using Python.

The SDK samples given below describe how to quickly make your application do add text and images to PDF in Python with the help of PDF.co Web API. Follow the instructions from scratch to work and copy the Python code. Check Python sample code samples to see if they respond to your needs and requirements for the project.

Trial version of PDF.co Web API is available for free. Source code samples are included to help you with your Python app.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore SDK Docs](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Documentation](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### **AddImageByFindingTargetCoordinates.py:**
    
```
import os
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
API_KEY = "**************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of source PDF file.
SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf"

# Search string.
SearchString = 'Your Company Name'

# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
Pages = ""

# PDF document password. Leave empty for unprotected documents.
Password = ""

# Destination PDF file name
DestinationFile = ".//result.pdf"

# Image params
Type = "image"
Width = 119
Height = 32
ImageUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png"


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

    url = "{}/pdf/find?url={}&searchString={}".format(
        BASE_URL,
        sourceFile,
        searchText
    )

    # Execute request and get response as JSON
    response = requests.get(url, headers={"x-api-key": API_KEY, "content-type": "application/octet-stream"})
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
    """Add image using PDF.co Web API"""

    # Prepare URL for 'PDF Edit' API request
    url = "{}/pdf/edit/add?name={}&password={}&pages={}&url={}&type={}&x={}&y={}&width={}&height={}&urlimage={}".format(
        BASE_URL,
        os.path.basename(destinationFile),
        Password,
        Pages,
        SourceFileUrl,
        Type,
        top + 300,
        left,
        Width,
        Height,
        ImageUrl
    )

    # Execute request and get response as JSON
    response = requests.get(url, headers={ "x-api-key": API_KEY, "content-type": "application/octet-stream" })

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