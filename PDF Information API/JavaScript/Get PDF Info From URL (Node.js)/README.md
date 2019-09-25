## How to get PDF info from URL (node for PDF information API in JavaScript and PDF.co Web API

### Step By Step Tutorial: how to get PDF info from URL (node for PDF information API in JavaScript

On this page you will learn from code samples for programming in JavaScript. PDF.co Web API was made to help with PDF information API in JavaScript. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

You will save a lot of time on writing and testing code as you may just take the code below and use it in your application. This JavaScript sample code should be copied and pasted into your project. After doing this just compile your project and click Run. Enjoy writing a code with ready-to-use sample JavaScript codes to add PDF information API functions using PDF.co Web API in JavaScript.

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

##### ****GetPdfInfoFromUrl.js:**
    
```
var https = require("https");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";


// Direct URL of PDF file to get information
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf";


// Prepare request to `PDF Info` API endpoint
var queryPath = `/v1/pdf/info?url=${SourceFileUrl}`;
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
            // Display PDF document information
            for (var key in data.info) {  
                console.log(`${key}: ${data.info[key]}`);
            }  
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