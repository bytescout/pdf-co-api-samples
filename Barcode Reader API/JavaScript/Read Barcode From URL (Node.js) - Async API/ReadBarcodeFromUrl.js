//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Free Trial Sign Up: https://secure.bytescout.com/users/sign_up //
//                                                                                           //
// Copyright © 2017-2018 ByteScout Inc. All rights reserved.                                 //
// http://www.bytescout.com                                                                  //
//                                                                                           //
//*******************************************************************************************//


var https = require("https");

// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Direct URL of source file to search barcodes in.
const SourceFileUrl = "https://s3-us-west-2.amazonaws.com/bytescout-com/files/demo-files/cloud-api/barcode-reader/sample.pdf";
// Comma-separated list of barcode types to search. 
// See valid barcode types in the documentation https://app.pdf.co/documentation/api/1.0/barcode/read_from_url.html
const BarcodeTypes = "Code128,Code39,Interleaved2of5,EAN13";
// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";


// Prepare request to `Barcode Reader` API endpoint
var queryPath = `/v1/barcode/read/from/url?types=${BarcodeTypes}&pages=${Pages}&url=${SourceFileUrl}&async=True`;
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
            console.log(`Job #${data.jobId} has been created!`);
            checkIfJobIsCompleted(data.jobId, data.url);
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

function checkIfJobIsCompleted(jobId, resultFileUrlJson) {
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
            console.log(`Checking Job #${jobId}, Status: ${data.Status}, Time: ${new Date().toLocaleString()}`);

            if (data.Status == "InProgress") {
                // Check again after 3 seconds
				setTimeout(function(){ checkIfJobIsCompleted(jobId, resultFileUrlJson);}, 3000);
            }
            else if (data.Status == "Finished") {

                request({ method: 'GET', uri: resultFileUrlJson, gzip: true },
                function (error, response, body) {

                    //* workaround for issue with non supoprted firstchar code
                    var firstCharCode = body.charCodeAt(0);
                    if (firstCharCode == 65279) {
                        body = body.substring(1);
                    }

                    // Parse JSON response
                    let respJsonFileArray = JSON.parse(body);

                    respJsonFileArray.forEach((element) => {
                        console.log("Found barcode:");
                        console.log("  Type: " + element["TypeName"]);
                        console.log("  Value: " + element["Value"]);
                        console.log("  Document Page Index: " + element["Page"]);
                        console.log("  Rectangle: " + element["Rect"]);
                        console.log("  Confidence: " + element["Confidence"]);
                        console.log();
                    }, this);
                });
            }
            else {
                console.log(`Operation ended with status: "${data.Status}".`);
            }
        })
    });
}
