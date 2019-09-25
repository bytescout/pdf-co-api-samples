## How to split PDF from URL (node for PDF splitting API in JavaScript with PDF.co Web API

### Step By Step Tutorial: how to split PDF from URL (node for PDF splitting API in JavaScript

The documentation is designed to help you to implement the features on your side. PDF splitting API in JavaScript can be implemented with PDF.co Web API. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

This rich sample source code in JavaScript for PDF.co Web API includes the number of functions and options you should do calling the API to implement PDF splitting API. This JavaScript sample code should be copied and pasted into your project. After doing this just compile your project and click Run. Use of PDF.co Web API in JavaScript is also explained in the documentation included along with the product.

Trial version of ByteScout is available for free download from our website. This and other source code samples for JavaScript and other programming languages are available.

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

##### ****SplitPdfFromUrl.js:**
    
```
var https = require("https");
var fs = require("fs");

// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Source PDF file to split
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf";
// Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
const Pages = "1-2,3-";


// Prepare request to `Split PDF` API endpoint
var queryPath = `/v1/pdf/split?pages=${Pages}&url=${SourceFileUrl}&async=True`;
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
            console.log(`Job #${data.jobId} has been created!`);
            checkIfJobIsCompleted(data.jobId, data.url);
        }
        else {
            // Service reported error
            console.log(data.message);
        }
    });
}).on("error", (e) => {
    // Request error
    console.error(e);
});

function checkIfJobIsCompleted(jobId, resultFileUrlJson) {

    let queryPath = `/v1/job/check?jobid=${jobId}`;
    let reqOptions = {
        host: "api.pdf.co",
        path: encodeURI(queryPath),
        method: "GET",
        headers: { "x-api-key": API_KEY }
    };

    https.get(reqOptions, (response) => {
        response.on("data", (d) => {
            response.setEncoding("utf8");

            // Parse JSON response
            let data = JSON.parse(d);
            console.log(`Checking Job #${jobId}, Status: ${data.status}, Time: ${new Date().toLocaleString()}`);

            if (data.status == "working") {
                // Check again after 3 seconds
                setTimeout(function(){checkIfJobIsCompleted(jobId, resultFileUrlJson)} , 3000);
            }
            else if (data.status == "success") {

                request({ method: 'GET', uri: resultFileUrlJson, gzip: true },
                    function (error, response, body) {

                        // Parse JSON response
                        let respJsonFileArray = JSON.parse(body);
                        let part = 1;

                        respJsonFileArray.forEach((url) => {
                            var localFileName = `./part${part}.png`;
                            var file = fs.createWriteStream(localFileName);
                            https.get(url, (response2) => {
                                response2.pipe(file)
                                    .on("close", () => {
                                        console.log(`Generated PDF file saved as "${localFileName} file."`);
                                    });
                            });
                            part++;
                        }, this);

                    });
            }
            else {
                console.log(`Operation ended with status: "${data.status}".`);
            }
        })
    });
}

```

<!-- code block end -->