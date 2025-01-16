import os
import requests # pip install requests
import time
import datetime

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "*********************************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Source PDF file
SourceFile = ".\\Sample PDF File With HyperLinks.pdf"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
Pages = ""
# PDF document password. Leave empty for unprotected documents.
Password = ""
# Destination JSON file name
DestinationFile = ".\\result.json"

# (!) Make asynchronous job
Async = True


def main(args = None):
    uploadedFileUrl = uploadFile(SourceFile)
    if (uploadedFileUrl != None):
        convertPdfToJson(uploadedFileUrl, DestinationFile)


def convertPdfToJson(uploadedFileUrl, destinationFile):
    """Converts PDF To Json using PDF.co Web API"""

    # Some of advanced options available through profiles:
    # (it can be single/double-quoted and contain comments.)
    # {
    #     "profiles": [
    #         {
    #             "profile1": {
    #                 "SaveImages": "None", // Whether to extract images. Values: "None", "Embed".
    #                 "ImageFormat": "PNG", // Image format for extracted images. Values: "PNG", "JPEG", "GIF", "BMP".
    #                 "SaveVectors": false, // Whether to extract vector objects (vertical and horizontal lines). Values: true / false
    #                 "ExtractInvisibleText": true, // Invisible text extraction. Values: true / false
    #                 "ExtractShadowLikeText": true, // Shadow-like text extraction. Values: true / false
    #                 "LineGroupingMode": "None", // Values: "None", "GroupByRows", "GroupByColumns", "JoinOrphanedRows"
    #                 "ColumnDetectionMode": "ContentGroupsAndBorders", // Values: "ContentGroupsAndBorders", "ContentGroups", "Borders", "BorderedTables"
    #                 "Unwrap": false, // Unwrap grouped text in table cells. Values: true / false
    #                 "ShrinkMultipleSpaces": false, // Shrink multiple spaces in table cells that affect column detection. Values: true / false
    #                 "DetectNewColumnBySpacesRatio": 1, // Spacing ratio that affects column detection.
    #                 "CustomExtractionColumns": [ 0, 50, 150, 200, 250, 300 ], // Explicitly specify columns coordinates for table extraction.
    #                 "CheckPermissions": true, // Ignore document permissions. Values: true / false
    #             }
    #         }
    #     ]
    # }

    # Sample profile that sets advanced conversion options
    # Advanced options are properties of JSONExtractor class from ByteScout JSON Extractor SDK used in the back-end:
    # https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/84356d44-6249-3251-2da8-83c1f34a2f39.htm
    profiles = '{ "profiles": [ { "profile1": { "OutputStructure": "OnlyLinks", "OutputTransformation": "$..text" } } ] }'

    # Prepare requests params as JSON
    # See documentation: https://apidocs.pdf.co
    parameters = {}
    parameters["name"] = os.path.basename(destinationFile)
    parameters["password"] = Password
    parameters["pages"] = Pages
    parameters["url"] = uploadedFileUrl
    parameters["profiles"] = profiles
    parameters["async"] = Async


    # Prepare URL for 'PDF To Json' API request
    url = "{}/pdf/convert/to/json".format(BASE_URL)

     # Execute request and get response as JSON
    response = requests.post(url, data=parameters, headers={ "x-api-key": API_KEY })
    if (response.status_code == 200):
        json = response.json()

        if json["error"] == False:
            # Asynchronous job ID
            jobId = json["jobId"]
            #  URL of the result file
            resultFileUrl = json["url"]
            
            # Check the job status in a loop. 
            # If you don't want to pause the main thread you can rework the code 
            # to use a separate thread for the status checking and completion.
            while True:
                status = checkJobStatus(jobId) # Possible statuses: "working", "failed", "aborted", "success".
                
                # Display timestamp and status (for demo purposes)
                print(datetime.datetime.now().strftime("%H:%M.%S") + ": " + status)
                
                if status == "success":
                    # Download result file
                    r = requests.get(resultFileUrl, stream=True)
                    if (r.status_code == 200):
                        with open(destinationFile, 'wb') as file:
                            for chunk in r:
                                file.write(chunk)
                        print(f"Result file saved as \"{destinationFile}\" file.")
                    else:
                        print(f"Request error: {response.status_code} {response.reason}")
                    break
                elif status == "working":
                    # Pause for a few seconds
                    time.sleep(3)
                else:
                    print(status)
                    break
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")


def checkJobStatus(jobId):
    """Checks server job status"""

    url = f"{BASE_URL}/job/check?jobid={jobId}"
    
    response = requests.get(url, headers={ "x-api-key": API_KEY })
    if (response.status_code == 200):
        json = response.json()
        return json["status"]
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


def uploadFile(fileName):
    """Uploads file to the cloud"""
    
    # 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.

    # Prepare URL for 'Get Presigned URL' API request
    url = "{}/file/upload/get-presigned-url?contenttype=application/octet-stream&name={}".format(
        BASE_URL, os.path.basename(fileName))
    
    # Execute request and get response as JSON
    response = requests.get(url, headers={ "x-api-key": API_KEY })
    if (response.status_code == 200):
        json = response.json()
        
        if json["error"] == False:
            # URL to use for file upload
            uploadUrl = json["presignedUrl"]
            # URL for future reference
            uploadedFileUrl = json["url"]

            # 2. UPLOAD FILE TO CLOUD.
            with open(fileName, 'rb') as file:
                requests.put(uploadUrl, data=file, headers={ "x-api-key": API_KEY, "content-type": "application/octet-stream" })

            return uploadedFileUrl
        else:
            # Show service reported error
            print(json["message"])    
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


if __name__ == '__main__':
    main()

            