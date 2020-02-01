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
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Source PDF file
const SourceFile = "./MultiPageTable.pdf";
// PDF document password. Leave empty for unprotected documents.
const Password = "";
// Destination PDF file name
const DestinationFile = "./result.json";

// 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.
getPresignedUrl(API_KEY, SourceFile)
    .then(([uploadUrl, uploadedFileUrl]) => {
        // 2. UPLOAD THE FILE TO CLOUD.
        uploadFile(API_KEY, SourceFile, uploadUrl)
            .then(() => {
                // 3. OPTIMIZE UPLOADED PDF FILE
                parsePdf(API_KEY, uploadedFileUrl, Password, DestinationFile);
            })
            .catch(e => {
                console.log(e);
            });
    })
    .catch(e => {
        console.log(e);
    });


function getPresignedUrl(apiKey, localFile) {
    return new Promise(resolve => {
        // Prepare request to `Get Presigned URL` API endpoint
        let queryPath = `/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=${path.basename(SourceFile)}`;
        let reqOptions = {
            host: "api.pdf.co",
            path: encodeURI(queryPath),
            headers: { "x-api-key": API_KEY }
        };
        // Send request
        https.get(reqOptions, (response) => {
            response.on("data", (d) => {
                let data = JSON.parse(d);
                if (data.error == false) {
                    // Return presigned url we received
                    resolve([data.presignedUrl, data.url]);
                }
                else {
                    // Service reported error
                    console.log("getPresignedUrl(): " + data.message);
                }
            });
        })
            .on("error", (e) => {
                // Request error
                console.log("getPresignedUrl(): " + e);
            });
    });
}

function uploadFile(apiKey, localFile, uploadUrl) {
    return new Promise(resolve => {
        fs.readFile(SourceFile, (err, data) => {
            request({
                method: "PUT",
                url: uploadUrl,
                body: data,
                headers: {
                    "Content-Type": "application/octet-stream"
                }
            }, (err, res, body) => {
                if (!err) {
                    resolve();
                }
                else {
                    console.log("uploadFile() request error: " + e);
                }
            });
        });
    });
}

function parsePdf(apiKey, uploadedFileUrl, password, destinationFile) {

    // Template text. Use Document Parser SDK (https://bytescout.com/products/developer/documentparsersdk/index.html)
    // to create templates.
    // Read template from file:
    var templateText = fs.readFileSync("./MultiPageTable-template1.yml", "utf-8");

    // URL for `Document Parser` API call
    var query = `https://api.pdf.co/v1/pdf/documentparser`;
    var jsonRequestObject = {
        url: uploadedFileUrl,
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
                var file = fs.createWriteStream(destinationFile);
                https.get(data.url, (response2) => {
                    response2.pipe(file)
                        .on("close", () => {
                            console.log(`Generated result file saved as "${destinationFile}" file.`);
                        });
                });
            }
            else {
                // Service reported error
                console.log("Error: " + data.message);
            }
        }
    );
}

