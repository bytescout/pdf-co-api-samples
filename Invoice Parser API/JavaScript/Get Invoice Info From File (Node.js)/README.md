## How to get invoice info from file (node for invoice parser API in JavaScript with PDF.co Web API

### Follow this simple tutorial to learn get invoice info from file (node to have invoice parser API in JavaScript

These simple tutorials explain the code material for beginners and advanced programmers who are using JavaScript. PDF.co Web API was designed to assist invoice parser API in JavaScript. PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

The SDK samples displayed below below explain how to quickly make your application do invoice parser API in JavaScript with the help of PDF.co Web API.  This sample code in JavaScript is all you need. Just copy-paste it to the code editor, then add a reference to PDF.co Web API and you are ready to try it! This basic programming language sample code for JavaScript will do the whole work for you in implementing invoice parser API in your app.

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

##### **GetInvoiceInfoFromFile.js:**
    
```
/*jshint esversion: 6 */

var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";


// Source PDF file to get information
const SourceFile = "./sample.pdf";

// Prepare URL for `Invoice Parser` API call
var query = `https://api.pdf.co/v1/pdf/invoiceparser?inline=True`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
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
         // Display PDF document information
         for (var key in data.body) {  
            console.log(`${key}: ${data.info[key]}`);
        }
    }
    else {
        // Service reported error
        console.log("Error: " + data.message);
    }
});
```

<!-- code block end -->