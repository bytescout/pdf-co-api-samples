## How to parse from uploaded file for document parser API in Python with PDF.co Web API

### Learn to write code parse from uploaded file for document parser API in Python: Simple How To Tutorial

The documentation is written to assist you to apply all the necessary features on your side. PDF.co Web API was designed to assist document parser API in Python. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

Want to learn quickly? These fast application programming interfaces of PDF.co Web API for Python plus the instruction and the code below will help to learn how to parse from uploaded file. Open your Python project and simply copy & paste the code and then run your app!  Easy to understand tutorials are available along with installed PDF.co Web API if you'd like to learn more about the topic and the details of the API.

PDF.co Web API - free trial version is available on our website. Also, there are other code samples to help you with your Python application included into trial version.

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

##### **MultiPageTable-template1.yml:**
    
```
---
# Template that demonstrates parsing of multi-page table using only 
# regular expressions for the table start, end, and rows.
# If regular expression cannot be written for every table row (for example, 
# if the table contains empty cells), try the second method demonstrated 
# in 'MultiPageTable-template2.yml' template.
templateVersion: 2
templatePriority: 0
sourceId: Multipage Table Test
detectionRules:
  keywords:
  - Sample document with multi-page table
fields:
  total:
    expression: TOTAL {{DECIMAL}}    
tables:
- name: table1
  start:
    # regular expression to find the table start in document
    expression: Item\s+Description\s+Price\s+Qty\s+Extended Price
  end:
    # regular expression to find the table end in document
    expression: TOTAL\s+\d+\.\d\d
  row:
    # regular expression to find table rows
    expression: '^\s*(?<itemNo>\d+)\s+(?<description>.+?)\s+(?<price>\d+\.\d\d)\s+(?<qty>\d+)\s+(?<extPrice>\d+\.\d\d)'
  columns: 
  - name: itemNo
    type: integer
  - name: description
    type: string
  - name: price
    type: decimal
  - name: qty
    type: integer
  - name: extPrice
    type: decimal
  multipage: true
```

<!-- code block end -->    

<!-- code block begin -->

##### **ParseFromUploadedFile.py:**
    
```
import os
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
API_KEY = "*************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Source PDF file
SourceFile = ".\\MultiPageTable.pdf"

# Destination JSON file name
DestinationFile = ".\\result.json"

# Template text. Use Document Parser SDK (https://bytescout.com/products/developer/documentparsersdk/index.html)
# to create templates.
# Read template from file:
file_read = open(".\\MultiPageTable-template1.yml", mode='r', encoding="utf-8",errors="ignore")
Template = file_read.read()
file_read.close()

def main(args = None):
    uploadedFileUrl = uploadFile(SourceFile)

    if (uploadedFileUrl != None):
        PerformDocumentParser(uploadedFileUrl, Template, DestinationFile)

def PerformDocumentParser(uploadedFileUrl, template, destinationFile):

    # Content
    data = {
        'url': uploadedFileUrl,
        'template': template
    }

    # Prepare URL for 'Document Parser' API request
    url = "{}/pdf/documentparser".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, data= data, headers={ "x-api-key": API_KEY })

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


def uploadFile(fileName):
    """Uploads file to the cloud"""

    # 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.

    # Prepare URL for 'Get Presigned URL' API request
    url = "{}/file/upload/get-presigned-url?contenttype=application/octet-stream&name={}".format(
        BASE_URL, os.path.basename(fileName))

    # Execute request and get response as JSON
    response = requests.get(url, headers={"x-api-key": API_KEY})
    if (response.status_code == 200):
        json = response.json()

        if json["error"] == False:
            # URL to use for file upload
            uploadUrl = json["presignedUrl"]
            # URL for future reference
            uploadedFileUrl = json["url"]

            # 2. UPLOAD FILE TO CLOUD.
            with open(fileName, 'rb') as file:
                requests.put(uploadUrl, data=file,
                             headers={"x-api-key": API_KEY, "content-type": "application/octet-stream"})

            return uploadedFileUrl
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


if __name__ == '__main__':
    main()
```

<!-- code block end -->