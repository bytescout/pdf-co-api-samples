## How to add text and images to PDF in Python using PDF.co Web API

### Learning is essential in computer world and the tutorial below will demonstrate how to add text and images to PDF in Python

Add text and images to PDF is simple to apply in Python if you use these source codes below. PDF.co Web API can add text and images to PDF. It can be applied from Python. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

Want to quickly learn? This fast application programming interfaces of PDF.co Web API for Python plus the guidelines and the code below will help you quickly learn how to add text and images to PDF. Follow the instructions from scratch to work and copy the Python code. This basic programming language sample code for Python will do the whole work for you to add text and images to PDF.

Trial version of PDF.co Web API is available for free. Source code samples are included to help you with your Python app.

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

##### **AddImagesToExistingPDF.py:**
    
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

#Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
Pages = ""

# PDF document password. Leave empty for unprotected documents.
Password = ""

# Destination PDF file name
DestinationFile = ".//result.pdf"

# Image params
Type = "image"
X = 400
Y = 20
Width = 119
Height = 32
ImageUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png"


def main(args = None):
    addImageToExistingPdf(DestinationFile)

def addImageToExistingPdf(destinationFile):
    """Add image using PDF.co Web API"""

    # Prepare URL for 'PDF Edit' API request
    url = "{}/pdf/edit/add?name={}&password={}&pages={}&url={}&type={}&x={}&y={}&width={}&height={}&urlimage={}".format(
        BASE_URL,
        os.path.basename(destinationFile),
        Password,
        Pages,
        SourceFileUrl,
        Type,
        X,
        Y,
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