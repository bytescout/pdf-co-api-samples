## How to convert PDF to PNG from file (node for PDF to image API in JavaScript with PDF.co Web API

### How to convert PDF to PNG from file (node in JavaScript with easy ByteScout code samples to make PDF to image API. Step-by-step tutorial

Writing of the code to convert PDF to PNG from file (node in JavaScript can be done by developers of any level using PDF.co Web API. PDF to image API in JavaScript can be implemented with PDF.co Web API. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

This rich sample source code in JavaScript for PDF.co Web API includes the number of functions and options you should do calling the API to implement PDF to image API. Follow the instruction and copy - paste code for JavaScript into your project's code editor. Writing JavaScript application typically includes multiple stages of the software development so even if the functionality works please test it with your data and the production environment.

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

##### ****ConvertPdfToPngFromFile.js:**
    
```
/*jshint esversion: 6 */

var https = require("https");
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

// Prepare URL for `PDF To PNG` API call
var query = `https://api.pdf.co/v1/pdf/convert/to/png`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
        password: Password,
        pages: Pages,
        file: fs.createReadStream(SourceFile)
    }
};

// Send request
request.post(reqOptions, function (error, response, body) {
    if (error) {
        return console.error("Error: ", error);
    }

    // Parse JSON response
    let data = JSON.parse(body);
    if (data.error == false) {
        // Download generated PNG files
        var page = 1;
        data.urls.forEach((url) => {
            var localFileName = `./page${page}.png`;
            var file = fs.createWriteStream(localFileName);
            https.get(url, (response2) => {
                response2.pipe(file)
                .on("close", () => {
                    console.log(`Generated PNG file saved as "${localFileName}" file.`);
                });
            });
            page++;
        }, this);
    }
    else {
        // Service reported error
        console.log("Error: " + data.message);
    }
});
```

<!-- code block end -->