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


var https = require("https");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";


// Direct URL of PDF file to get information
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf";


// Prepare request to `Invoice Parser` API endpoint
var queryPath = `/v1/pdf/invoiceparser`;

// JSON payload for api request
var jsonPayload = JSON.stringify({
    url: SourceFileUrl, inline: true
});

var reqOptions = {
    host: "api.pdf.co",
    method: "POST",
    path: queryPath,
    headers: {
        "x-api-key": API_KEY,
        "Content-Type": "application/json",
        "Content-Length": Buffer.byteLength(jsonPayload, 'utf8')
    }
};
// Send request
var postRequest = https.request(reqOptions, (response) => {
    response.on("data", (d) => {
        // Parse JSON response
        var data = JSON.parse(d);
        if (data.error == false) {
            // Display extracted invoice fields
            for (var key in data.body) {
                console.log(`${key}: ${JSON.stringify(data.body[key])}`);
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

// Write request data
postRequest.write(jsonPayload);
postRequest.end();
