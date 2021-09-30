## How to get invoice info from URL for invoice parser API in Python using PDF.co Web API

### Step By Step Instructions on how to get invoice info from URL for invoice parser API in Python

We regularly create and update our sample code library so you may quickly learn invoice parser API and the step-by-step process in Python. PDF.co Web API was designed to assist invoice parser API in Python. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

The SDK samples displayed below below explain how to quickly make your application do invoice parser API in Python with the help of PDF.co Web API. Follow the tutorial and copy - paste code for Python into your project's code editor. This basic programming language sample code for Python will do the whole work for you in implementing invoice parser API in your app.

Free! Free! Free! ByteScout free trial version is available for FREE download from our website. Programming tutorials along with source code samples are assembled.

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

##### **GetInvoiceInfoFromUrl.py:**
    
```
import os
import requests  # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "******************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of PDF file to get information
SourceFileURL = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf"


def main(args=None):
    getInfoFromUrl(SourceFileURL)


def getInfoFromUrl(uploadedFileUrl):
    """Get Information using PDF.co Web API"""

    # Prepare requests params as JSON
    # See documentation: https://apidocs.pdf.co
    parameters = {}
    parameters["url"] = uploadedFileUrl
    parameters["inline"] = True

    # Prepare URL for 'invoice info' API request
    url = "{}/pdf/invoiceparser".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, data=parameters, headers={ "x-api-key": API_KEY })
    if (response.status_code == 200):
        json = response.json()

        if json["error"] == False:
            # Display information
            print(json["body"])
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

if __name__ == '__main__':
    main()
```

<!-- code block end -->