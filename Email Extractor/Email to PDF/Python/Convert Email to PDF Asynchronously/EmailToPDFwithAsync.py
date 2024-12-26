import os
import requests
import json
import time
import datetime

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "************************************************8"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of source PDF file.
SourceFileUrl = "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml"
# PDF document password. Leave empty for unprotected documents.
Password = ""

# Destination PDF file name
DestinationFile = ".result.pdf"

# Runs processing asynchronously. Returns Use JobId that you may use with /job/check to check state of the processing (possible states: working, failed, aborted and success). Must be one of: true, false.
Async = "True"

paperSize = "Letter"

# Convert boolean values to string "true" or "false"
embedAttachments = "true"  # Change from boolean True to string "true"
convertAttachments = "true"  # Change from boolean True to string "true"

def main(args = None):
    convertEmail(SourceFileUrl, DestinationFile)

def convertEmail(uploadedFileUrl, destinationFile):
    """Converts Email to PDF using PDF.co Web API"""

    # Prepare requests params as JSON
    parameters = {}
    parameters["name"] = os.path.basename(destinationFile)
    parameters["url"] = uploadedFileUrl
    parameters["async"] = Async
    parameters["embedAttachments"] = embedAttachments  # Use string "true"
    parameters["convertAttachments"] = convertAttachments  # Use string "true"
    parameters["paperSize"] = paperSize

    # Prepare URL for 'Fill PDF' API request
    url = "{}/pdf/convert/from/email".format(BASE_URL)

    # Execute request and get response as JSON
    response = requests.post(url, data=parameters, headers={ "x-api-key": API_KEY })
    
    if response.status_code == 200:
        json_response = response.json()

        # If there are no errors, proceed to poll for job status
        if not json_response.get("error", False):
            # Extract the jobId from the response
            jobId = json_response.get("jobId")
            if jobId:
                print(f"Job ID: {jobId}")  # Output job ID

                # Poll the job status
                while True:
                    status = checkJobStatus(jobId)
                    print(datetime.datetime.now().strftime("%H:%M.%S") + ": " + status)

                    if status == "success":
                        # Extract the result URL to the final PDF
                        resultJsonUrl = json_response["url"]
                        print(f"Result PDF URL: {resultJsonUrl}")  # Print the result JSON URL

                        # Fetch the result JSON to get the PDF URL
                        fetchAndDownloadPdf(resultJsonUrl, destinationFile)
                        break
                    elif status == "working":
                        # Pause for a few seconds before polling again
                        time.sleep(3)
                    else:
                        print(status)
                        break
        else:
            print(f"Error: {json_response.get('message', 'Unknown error')}")
    else:
        # Print out the response body for further debugging
        print(f"Request error: {response.status_code} {response.reason}")
        print("Response Body:", response.text)


def fetchAndDownloadPdf(resultJsonUrl, destinationFile):
    """Fetch the final PDF URL and download the PDF"""
    # Directly download the PDF from the result URL
    pdf_response = requests.get(resultJsonUrl, headers={"x-api-key": API_KEY}, stream=True)

    if pdf_response.status_code == 200:
        # Save the PDF file to the specified destination
        with open(destinationFile, 'wb') as file:
            for chunk in pdf_response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"Result PDF saved as \"{destinationFile}\".")  # Final result message
    else:
        print(f"Error downloading PDF: {pdf_response.status_code} {pdf_response.reason}")


def checkJobStatus(jobId):
    """Checks server job status"""
    url = f"{BASE_URL}/job/check?jobid={jobId}"

    response = requests.get(url, headers={"x-api-key": API_KEY})
    if response.status_code == 200:
        json_response = response.json()
        return json_response["status"]
    else:
        print(f"Request error: {response.status_code} {response.reason}")

    return None


if __name__ == '__main__':
    main()
