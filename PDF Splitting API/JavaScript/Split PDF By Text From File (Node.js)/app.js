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

var https = require("https");
var path = require("path");
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co
const API_KEY = "***********************************";


// Source PDF file to split
const SourceFile = "./sample.pdf";
// Split Search String
const SplitText = "invoice number";

// Prepare URL for `Split PDF By Text` API endpoint
var query = `https://api.pdf.co/v1/pdf/split2`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
        searchString: SplitText,
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
        console.log("Error: " + data.message);
    }
});
