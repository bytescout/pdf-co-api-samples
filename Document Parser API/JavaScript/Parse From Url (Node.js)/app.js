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
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Source PDF file
// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
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
