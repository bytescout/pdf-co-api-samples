## How to split PDF from URL (node for PDF splitting API in JavaScript and PDF.co Web API

### How to split PDF from URL (node for PDF splitting API in JavaScript: Step By Step Tutorial

Writing of the code to split PDF from URL (node in JavaScript can be done by developers of any level using PDF.co Web API. PDF.co Web API helps with PDF splitting API in JavaScript. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

You will save a lot of time on writing and testing code as you may just take the code below and use it in your application. Follow the instruction and copy - paste code for JavaScript into your project's code editor. You can use these JavaScript sample examples in one or many applications.

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

##### ****SplitPdfFromUrl.js:**
    
```
var https = require("https");
var fs = require("fs");


// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";


// Source PDF file to split
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf";
// Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
const Pages = "1-2,3-";


// Prepare request to `Split PDF` API endpoint
var queryPath = `/v1/pdf/split?pages=${Pages}&url=${SourceFileUrl}`;
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
            // Download generated PDF files
            var part = 1;
            data.urls.forEach((url) => {
                var localFileName = `./part${part}.pdf`;
                var file = fs.createWriteStream(localFileName);
                https.get(url, (response2) => {
                    response2.pipe(file)
                    .on("close", () => {
                        console.log(`Generated PDF file saved as "${localFileName}" file.`);
                    });
                });
                part++;
            }, this);
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

```

<!-- code block end -->