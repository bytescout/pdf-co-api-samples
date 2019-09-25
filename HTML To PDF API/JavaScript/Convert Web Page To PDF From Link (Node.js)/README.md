## How to convert web page to PDF from link (node for HTML to PDF API in JavaScript using PDF.co Web API

### How to convert web page to PDF from link (node for HTML to PDF API in JavaScript: Step By Step Tutorial

Writing of the code to convert web page to PDF from link (node in JavaScript can be done by developers of any level using PDF.co Web API. PDF.co Web API was made to help with HTML to PDF API in JavaScript. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

Fast application programming interfaces of PDF.co Web API for JavaScript plus the instruction and the code below will help to learn how to convert web page to PDF from link (node. For implimentation of this functionality, please copy and paste code below into your app using code editor. Then compile and run your app. Code testing will allow the function to be tested and work properly with your data.

PDF.co Web API - free trial version is on available our website. Also, there are other code samples to help you with your JavaScript application included into trial version.

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

##### ****ConvertWebPageToPdfFromLink.js:**
    
```
var https = require("https");
var path = require("path");
var fs = require("fs");


// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";


// URL of web page to convert to PDF document.
const SourceUrl = "http://www.usa.gov";
// Destination PDF file name
const DestinationFile = "./result.pdf";


// Prepare request to `Web Page to PDF` API endpoint
var queryPath = `/v1/pdf/convert/from/url?name=${path.basename(DestinationFile)}&url=${SourceUrl}`;
var reqOptions = {
    host: "api.pdf.co",
    path: encodeURI(queryPath),
    headers: {
        "x-api-key": API_KEY
    }
};
// Send request
https.get(reqOptions, (response) => {
    response.on("data", (d) => {
        // Parse JSON response
        var data = JSON.parse(d);        
        if (data.error == false) {
            // Download PDF file
            var file = fs.createWriteStream(DestinationFile);
            https.get(data.url, (response2) => {
                response2.pipe(file)
                .on("close", () => {
                    console.log(`Generated PDF file saved as "${DestinationFile}" file.`);
                });
            });
        }
        else {
            // Service reported error
            console.log(data.message);
        }
    });
}).on("error", (e) => {
    // Request error
    console.log(e);
});

```

<!-- code block end -->