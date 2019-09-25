## How to PDF text search API in JavaScript with PDF.co Web API

### This tutorial will show how to PDF text search API in JavaScript

Learn how to PDF text search API in JavaScript with this source code sample. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf and you can use it to PDF text search API with JavaScript.

This code snippet below for PDF.co Web API works best when you need to quickly PDF text search API in your JavaScript application. This JavaScript sample code is all you need for your app. Just copy and paste the code, add references (if needs to) and you are all set! Test JavaScript sample code examples whether they respond your needs and requirements for the project.

You can download free trial version of PDF.co Web API from our website to see and try many others source code samples for JavaScript.

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

##### ****PdfTextSearchFromUrlAsyncApi.js:**
    
```
var https = require("https");

// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Direct URL of source PDF file.
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf";

// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";

// PDF document password. Leave empty for unprotected documents.
const Password = "";

// Search string. 
const SearchString = '[4-9][0-9].[0-9][0-9]'; // Regular expression to find numbers in format dd.dd and between 40.00 to 99.99

// Enable regular expressions (Regex) 
const RegexSearch = true;

// Prepare URL for PDF text search API call.
// See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html
var queryPath = `/v1/pdf/find?password=${Password}&pages=${Pages}&url=${SourceFileUrl}&searchString=${SearchString}&regexSearch=${RegexSearch}&async=True`;

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
    console.log(e);
});


function checkIfJobIsCompleted(jobId, resultFileUrl) {
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
                setTimeout(function () { checkIfJobIsCompleted(jobId, resultFileUrl); }, 3000);
            }
            else if (data.status == "success") {
                request({ method: 'GET', uri: resultFileUrl, gzip: true },
                    function (error, response, body) {

                        // Parse JSON response
                        let respJsonFileArray = JSON.parse(body);

                        respJsonFileArray.forEach((element) => {
                            console.log("Found text " + element["text"] + " at coordinates " + element["left"] + ", " + element["top"]);
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