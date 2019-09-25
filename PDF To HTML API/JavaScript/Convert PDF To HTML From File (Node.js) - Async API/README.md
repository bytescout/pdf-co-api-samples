## How to convert PDF to HTML from file (node for PDF to HTML API in JavaScript using PDF.co Web API

### How to convert PDF to HTML from file (node in JavaScript with easy ByteScout code samples to make PDF to HTML API. Step-by-step tutorial

The coding tutorials are designed to help you test the features without need to write your own code. PDF.co Web API helps with PDF to HTML API in JavaScript. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

You will save a lot of time on writing and testing code as you may just take the code below and use it in your application. Follow the instruction and copy - paste code for JavaScript into your project's code editor. Enjoy writing a code with ready-to-use sample JavaScript codes to add PDF to HTML API functions using PDF.co Web API in JavaScript.

ByteScout free trial version is available for FREE download from our website. Programming tutorials along with source code samples are included.

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

##### ****ConvertPdfToHtmlFromFile_AsyncApi.js:**
    
```
/*jshint esversion: 6 */

var https = require("https");
var path = require("path");
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Source PDF file
const SourceFile = "./sample.pdf";
// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";
// PDF document password. Leave empty for unprotected documents.
const Password = "";
// Destination HTML file name
const DestinationFile = "./result.html";
// Set to `true` to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
const PlainHtml = 'False';
// Set to `true` if your document has the column layout like a newspaper.
const ColumnLayout = 'False';


// Prepare request uri for `PDF To HTML` API endpoint
var query = `https://api.pdf.co/v1/pdf/convert/to/html`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
        name: path.basename(DestinationFile),
        password: Password,
        pages: Pages,
        simple: PlainHtml,
        columns: ColumnLayout,
        async: 'True',
        file: fs.createReadStream(SourceFile)
    },
};

// Send request
request.post(reqOptions, function (error, response, body) {
    if (error) {
        return console.error("Error: ", error);
    }

    // Parse JSON response
    let data = JSON.parse(body);
    console.log(`Job #${data.jobId} has been created!`);

    checkIfJobIsCompleted(data.jobId, data.url);
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
                setTimeout(function(){ checkIfJobIsCompleted(jobId, resultFileUrl); }, 3000);
            }
            else if (data.status == "success") {
                // Download HTML file
                var file = fs.createWriteStream(DestinationFile);
                https.get(resultFileUrl, (response2) => {
                    response2.pipe(file)
                        .on("close", () => {
                            console.log(`Generated HTML file saved as "${DestinationFile}" file.`);
                        });
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