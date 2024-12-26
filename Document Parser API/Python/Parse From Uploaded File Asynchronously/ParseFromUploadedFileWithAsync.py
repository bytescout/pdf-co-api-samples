import os
import requests  # pip install requests

# The authentication key (API Key).
API_KEY = "****************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Source PDF file
SourceFile = ".\\mathematica_expressions_sample.pdf"

# Destination JSON file name
DestinationFile = ".\\result.json"

# Template text. Use Document Parser (https://pdf.co/document-parser, https://app.pdf.co/document-parser)
# to create templates.
# Read template from file:
file_read = open(".\\template.json", mode='r', encoding="utf-8", errors="ignore")
Template = file_read.read()
file_read.close()


def main(args=None):
    uploadedFileUrl = uploadFile(SourceFile)

    if uploadedFileUrl is not None:
        # Now process the document with the uploaded URL (Async enabled)
        jobId = PerformDocumentParser(uploadedFileUrl, Template)

        if jobId:
            # Check job status
            resultFileUrl = checkJobStatus(jobId)

            if resultFileUrl:
                # Download the result file
                download_result(resultFileUrl, DestinationFile)
                print(f"Result file saved as \"{DestinationFile}\" file.")
            else:
                print(f"Error: No result file URL found for job {jobId}.")
        else:
            print("Job submission failed.")
    else:
        print("File upload failed.")


def uploadFile(fileName):
    """Uploads file to the cloud using a presigned URL"""

    # 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.
    url = "{}/file/upload/get-presigned-url?contenttype=application/octet-stream&name={}".format(
        BASE_URL, os.path.basename(fileName))

    # Execute request and get response as JSON
    response = requests.get(url, headers={"x-api-key": API_KEY})

    if response.status_code == 200:
        json = response.json()

        if not json["error"]:
            # URL to use for file upload
            uploadUrl = json["presignedUrl"]
            # URL for future reference
            uploadedFileUrl = json["url"]

            # 2. UPLOAD FILE TO CLOUD.
            with open(fileName, 'rb') as file:
                upload_response = requests.put(uploadUrl, data=file,
                                               headers={"x-api-key": API_KEY, "content-type": "application/octet-stream"})
                
                if upload_response.status_code == 200:
                    print("File uploaded successfully.")
                else:
                    print(f"Error uploading file: {upload_response.status_code} {upload_response.reason}")

            return uploadedFileUrl
        else:
            # Show service reported error
            print(json["message"])
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


def PerformDocumentParser(uploadedFileUrl, template):
    """Performs the document parser job (Async)"""
    # Content
    data = {
        'url': uploadedFileUrl,
        'template': template,
        'async': 'true'  # Set async to true
    }

    # Prepare URL for 'Document Parser' API request (Asynchronous version)
    url = "{}/pdf/documentparser".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, data=data, headers={"x-api-key": API_KEY})

    if response.status_code == 200:
        json = response.json()

        if not json.get("error", True):
            # Get the jobId from the response
            jobId = json["jobId"]
            print(f"Job started with Job ID: {jobId}")
            return jobId
        else:
            # Show service reported error
            print(f"API Error: {json['message']}")
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


def checkJobStatus(jobId):
    """Checks server job status and returns result URL if successful"""
    url = f"{BASE_URL}/job/check?jobid={jobId}"

    response = requests.get(url, headers={"x-api-key": API_KEY})
    if response.status_code == 200:
        json_response = response.json()
        status = json_response.get("status", "")
        
        # Log status for debugging
        print(f"Job Status: {status}")
        
        # If status is 'success', we assume it's completed and ready to download
        if status == 'success':
            # Fetch the result file URL from the job response
            result_file_url = json_response.get("url")
            if result_file_url:
                return result_file_url
            else:
                print(f"Error: No result file URL found in the response.")
        else:
            print(f"Job failed with status: {status}")
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


def download_result(resultFileUrl, destinationFile):
    """Download the result file"""
    if resultFileUrl is None:
        print("Error: The result file URL is missing.")
        return

    r = requests.get(resultFileUrl, stream=True)
    if r.status_code == 200:
        with open(destinationFile, 'wb') as file:
            for chunk in r.iter_content(chunk_size=8192):
                file.write(chunk)
    else:
        print(f"Request error: {r.status_code} {r.reason}")


if __name__ == '__main__':
    main()
