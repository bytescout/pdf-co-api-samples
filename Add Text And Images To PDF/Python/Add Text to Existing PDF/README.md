## How to add text and images to PDF in Python using PDF.co Web API

### Continuous learning is a crucial part of computer science and this tutorial shows how to add text and images to PDF in Python

Add text and images to PDF is simple to apply in Python if you use these source codes below. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf and you can use it to add text and images to PDF with Python.

The following code snippet for PDF.co Web API works best when you need to quickly add text and images to PDF in your Python application. Follow the instructions from scratch to work and copy the Python code. If you want to use these Python sample examples in one or many applications then they can be used easily.

The trial version of PDF.co Web API can be downloaded for free from our website. It also includes source code samples for Python and other programming languages.

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

##### **AddTextToExistingPDF.py:**
    
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

    # Prepare URL for 'PDF Edit' API request
    url = "{}/pdf/edit/add?name={}&password={}&pages={}&url={}&type={}&x={}&y={}&text={}&fontname={}&size={}&color={}".format(
        BASE_URL,
        os.path.basename(destinationFile),
        Password,
        Pages,
        SourceFileUrl,
        Type,
        X,
        Y,
        Text,
        FontName,
        FontSize,
        Color
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