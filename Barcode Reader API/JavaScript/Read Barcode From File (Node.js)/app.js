//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//


/*jshint esversion: 6 */
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co
const API_KEY = "******************************";

// Source file name
const SourceFile = "./sample.pdf";
// Comma-separated list of barcode types to search. 
// See valid barcode types in the documentation https://apidocs.pdf.co
const BarcodeTypes = "Code128,Code39,Interleaved2of5,EAN13";
// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";

// Prepare request to `Barcode Reader` API endpoint
var query = `https://api.pdf.co/v1/barcode/read/from/url`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
        types: BarcodeTypes,
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
    data.barcodes.forEach((element) => {
        console.log("Found barcode:");
        console.log("  Type: " + element["TypeName"]);
        console.log("  Value: " + element["Value"]);
        console.log("  Document Page Index: " + element["Page"]);
        console.log("  Rectangle: " + element["Rect"]);
        console.log("  Confidence: " + element["Confidence"]);
        console.log();
    }, this);
});
