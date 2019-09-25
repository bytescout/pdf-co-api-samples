## How to merge PDF documents from urls (node for PDF merging API in JavaScript and PDF.co Web API

### See how to merge PDF documents from urls (node to have PDF merging API in JavaScript

The documentation is designed to help you to implement the features on your side. PDF.co Web API was made to help with PDF merging API in JavaScript. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

Fast application programming interfaces of PDF.co Web API for JavaScript plus the instruction and the code below will help to learn how to merge PDF documents from urls (node. Sample code in JavaScript is all you need. Copy-paste it to your the code editor, then add a reference to PDF.co Web API and you are ready to try it! Further enhancement of the code will make it more vigorous.

Our website provides free trial version of PDF.co Web API that includes source code samples to help with your JavaScript project.

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

##### ****MergePdfDocumentsFromUrls.js:**
    
```
var https = require("https");
var path = require("path");
var fs = require("fs");


// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";


// Direct URLs of PDF files to merge
const SourceFiles = [
    "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf",
    "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample2.pdf"
];
// Destination PDF file name
const DestinationFile = "./result.pdf";


// Prepare request to `Merge PDF` API endpoint
var queryPath = `/v1/pdf/merge?name=${path.basename(DestinationFile)}&url=${SourceFiles.join(",")}`;
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