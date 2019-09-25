## How to parse from url (node for document parser API in JavaScript and PDF.co Web API

### Follow this simple tutorial to learn parse from url (node to have document parser API in JavaScript

We regularly create and update our sample code library so you may quickly learn document parser API and the step-by-step process in JavaScript. Document parser API in JavaScript can be applied with PDF.co Web API. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

This simple and easy to understand sample source code in JavaScript for PDF.co Web API contains different functions and options you should do calling the API to implement document parser API. For implementation of this functionality, please copy and paste the code below into your app using code editor. Then compile and run your app. Writing JavaScript application mostly includes various stages of the software development so even if the functionality works please check it with your data and the production environment.

Our website provides free trial version of PDF.co Web API that gives source code samples to assist with your JavaScript project.

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

##### ****MultiPageTable-template1.yml:**
    
```
---
# Template that demonstrates parsing of multi-page table using only 
# regular expressions for the table start, end, and rows.
# If regular expression cannot be written for every table row (for example, 
# if the table contains empty cells), try the second method demonstrated 
# in 'MultiPageTable-template2.yml' template.
templateVersion: 2
templatePriority: 0
sourceId: Multipage Table Test
detectionRules:
  keywords:
  - Sample document with multi-page table
fields:
  total:
    expression: TOTAL {{DECIMAL}}    
tables:
- name: table1
  start:
    # regular expression to find the table start in document
    expression: Item\s+Description\s+Price\s+Qty\s+Extended Price
  end:
    # regular expression to find the table end in document
    expression: TOTAL\s+\d+\.\d\d
  row:
    # regular expression to find table rows
    expression: '^\s*(?<itemNo>\d+)\s+(?<description>.+?)\s+(?<price>\d+\.\d\d)\s+(?<qty>\d+)\s+(?<extPrice>\d+\.\d\d)'
  columns: 
  - name: itemNo
    type: integer
  - name: description
    type: string
  - name: price
    type: decimal
  - name: qty
    type: integer
  - name: extPrice
    type: decimal
  multipage: true
```

<!-- code block end -->    

<!-- code block begin -->

##### ****ParsePdfFromUploadedFile.js:**
    
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
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/document-parser/MultiPageTable.pdf";

// Destination PDF file name
const DestinationFile = "./result.json";

// Template text. Use Document Parser SDK (https://bytescout.com/products/developer/documentparsersdk/index.html)
// to create templates.
// Read template from file:
var templateText = fs.readFileSync("./MultiPageTable-template1.yml", "utf-8");

// URL for `Document Parser` API call
var query = `https://api.pdf.co/v1/pdf/documentparser`;
var jsonRequestObject = {
    url: SourceFileUrl,
    template: templateText
};

request(
    {
        url: query,
        headers: { "x-api-key": API_KEY },
        method: "POST",
        json: true,
        body: jsonRequestObject
    },
    function (error, response, body) {

        if (error) {
            return console.error("Error: ", error);
        }

        // Parse JSON response
        let data = JSON.parse(JSON.stringify(body));

        if (data.error == false) {
            //Download generated file
            var file = fs.createWriteStream(DestinationFile);
            https.get(data.url, (response2) => {
                response2.pipe(file)
                    .on("close", () => {
                        console.log(`Generated result file saved as "${DestinationFile}" file.`);
                    });
            });
        }
        else {
            // Service reported error
            console.log("Error: " + data.message);
        }
    }
);
```

<!-- code block end -->