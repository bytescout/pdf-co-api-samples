import os
import requests
import json
import time
import datetime

# The authentication key (API Key).
API_KEY = "****************************************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Direct URL of source PDF file.
SourceFileUrl = "filetoken://109f2911ae7a36064cbbc107fe69fd4002f5775344f51c759b"

# Comma-separated list of page indices (or ranges) to process.
Pages = ""

# PDF document password. Leave empty for unprotected documents.
Password = ""

# Destination PDF file name
DestinationFile = ".//result.pdf"

# Image params
X = 360
Y = 500
Width = 300
Height = 300
ImageUrl = "filetoken://000bf19e383039b8a518fa5e5b386b56fd56da93619099f544"


def main(args=None):
    addImageToExistingPdf(DestinationFile)


def addImageToExistingPdf(destinationFile):
    """Add image using PDF.co Web API"""
    # Prepare requests params as JSON
    payload = json.dumps({
        "name": os.path.basename(destinationFile),
        "password": Password,
        "url": SourceFileUrl,
        "images": [{
            "url": ImageUrl,
            "x": X,
            "y": Y,
            "width": Width,
            "height": Height,
            "pages": Pages
        }],
        "async": True  # Ensure this triggers asynchronous mode if the API supports it
    })

    # Prepare URL for 'PDF Edit' API request
    url = f"{BASE_URL}/pdf/edit/add"

    # Execute request and get response as JSON
    response = requests.post(url, data=payload, headers={"x-api-key": API_KEY})
    if response.status_code == 200:
        json_response = response.json()

        # If there are no errors, proceed to download PDF directly
        if not json_response["error"]:
            # Asynchronous job ID
            jobId = json_response["jobId"]
            print(f"Job ID: {jobId}")

            # Poll the job status
            while True:
                status = checkJobStatus(jobId)
                print(datetime.datetime.now().strftime("%H:%M.%S") + ": " + status)

                if status == "success":
                    # Extract the URL to the result file (result.json)
                    resultJsonUrl = json_response["url"]
                    print(f"Result JSON URL: {resultJsonUrl}")  # Debug print to check the result URL
                    downloadPdf(resultJsonUrl, destinationFile)
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
        print(f"Request error: {response.status_code} {response.reason}")


def downloadPdf(resultJsonUrl, destinationFile):
    """Download the resulting PDF file directly from the result JSON URL"""
    print(f"Downloading PDF from: {resultJsonUrl}")  # Debug print to check the result URL

    # Fetch the result JSON file that contains the final PDF URL
    response = requests.get(resultJsonUrl, headers={"x-api-key": API_KEY})
    if response.status_code == 200:
        json_response = response.json()

        # Extract the actual PDF URL from the JSON response
        finalPdfUrl = json_response["url"]
        print(f"Final PDF URL: {finalPdfUrl}")  # Debug print to check the final PDF URL

        # Download the actual PDF
        pdf_response = requests.get(finalPdfUrl, headers={"x-api-key": API_KEY}, stream=True)
        if pdf_response.status_code == 200:
            with open(destinationFile, 'wb') as file:
                for chunk in pdf_response.iter_content(chunk_size=8192):
                    file.write(chunk)
            print(f"Result PDF saved as \"{destinationFile}\".")  # Final result
        else:
            print(f"Error downloading PDF: {pdf_response.status_code} {pdf_response.reason}")
    else:
        print(f"Error fetching result JSON: {response.status_code} {response.reason}")


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