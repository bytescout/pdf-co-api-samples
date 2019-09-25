## How to PDF text search API in JavaScript and PDF.co Web API

### This tutorial will show how to PDF text search API in JavaScript

This sample source code below will demonstrate you how to PDF text search API in JavaScript. What is PDF.co Web API? It is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf. It can help you to PDF text search API in your JavaScript application.

This code snippet below for PDF.co Web API works best when you need to quickly PDF text search API in your JavaScript application. In order to implement the functionality, you should copy and paste this code for JavaScript below into your code editor with your app, compile and run your application. Use of PDF.co Web API in JavaScript is also explained in the documentation included along with the product.

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

##### ****PDFTextSearchFromFile.js:**
    
```
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Source file name
const SourceFile = "./sample.pdf";

// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";

// PDF document password. Leave empty for unprotected documents.
const Password = "";

// Search string. 
const SearchString = '[4-9][0-9].[0-9][0-9]'; // Regular expression to find numbers in format dd.dd and between 40.00 to 99.99

// Enable regular expressions (Regex) 
const RegexSearch = 'True';

// Prepare URL for PDF text search API call.
// See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html
var query = `https://api.pdf.co/v1/pdf/find`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
        password: Password,
        pages: Pages,
        searchString: SearchString,
        regexSearch: RegexSearch,
        file: fs.createReadStream(SourceFile)
    }
};

// Send request
request.get(reqOptions, function (error, response, body) {
    if (error) {
        return console.error("Error: ", error);
    }

    // Parse JSON response
    let data = JSON.parse(body);
    for (let index = 0; index < data.body.length; index++) {
        const element = data.body[index];
        console.log("Found text " + element["text"] + " at coordinates " + element["left"] + ", " + element["top"]);
    }
});
```

<!-- code block end -->