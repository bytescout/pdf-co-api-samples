import os
import requests # pip install requests

# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co
API_KEY = "***************************"

# Base URL for PDF.co Web API requests
BASE_URL = "https://api.pdf.co/v1"

# Source PDF file url. You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
SourceFileURL = "https://pdf-temp-files.s3.amazonaws.com/R2FBM39LFX1BFC860O06XU0TL613JTZ9/f1040-form-filled.pdf "
Async = "False"

# Destination PDF file name
DestinationFile = ".\\result.pdf"

parameters = {}
parameters["async"] = Async
parameters["name"] = os.path.basename(DestinationFile)
parameters["url"] = SourceFileURL
 
# Prepare URL for 'Info Fields' API request
url = "{}/pdf/info/fields".format(BASE_URL)

response = requests.post(url, data=parameters, headers={ "x-api-key": API_KEY })
 
if (response.status_code == 200):
    json = response.json()
for field in json["info"]["FieldsInfo"]["Fields"]:print(field["FieldName"] + "=>" + field["Value"])
