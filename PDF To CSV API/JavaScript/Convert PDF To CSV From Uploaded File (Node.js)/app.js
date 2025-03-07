//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
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
const API_KEY = "***************************************";

// Source PDF file
const SourceFile = "./sample.pdf";
// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";
// PDF document password. Leave empty for unprotected documents.
const Password = "";
// Destination CSV file name
const DestinationFile = "./result.csv";


// 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.
getPresignedUrl(API_KEY, SourceFile)
    .then(([uploadUrl, uploadedFileUrl]) => {
        // 2. UPLOAD THE FILE TO CLOUD.
        uploadFile(API_KEY, SourceFile, uploadUrl)
            .then(() => {
                // 3. CONVERT UPLOADED PDF FILE TO CSV
                convertPdfToCsv(API_KEY, uploadedFileUrl, Password, Pages, DestinationFile);
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
        let queryPath = `/v1/file/upload/get-presigned-url?name=${path.basename(SourceFile)}`;
        let reqOptions = {
            host: "api.pdf.co",
            path: encodeURI(queryPath),
            headers: { "x-api-key": API_KEY }
        };
        // Send request
        https.get(reqOptions, (response) => {

            response.setEncoding('utf8');

            // Build response body in a string
            let resBody = '';
    
            // Listen for data and add
            response.on('data', function (chunk) {
                resBody += chunk
            });
    
            response.on("end", () => {
                let data = JSON.parse(resBody);
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

function convertPdfToCsv(apiKey, uploadedFileUrl, password, pages, destinationFile) {
    // Prepare request to `PDF To CSV` API endpoint
    const queryPath = `/v1/pdf/convert/to/csv`;

    // JSON payload for api request
    const jsonPayload = JSON.stringify({
        name: path.basename(destinationFile), password: password, pages: pages, url: uploadedFileUrl
    });

    const reqOptions = {
        host: "api.pdf.co",
        method: "POST",
        path: queryPath,
        headers: {
            "x-api-key": apiKey,
            "Content-Type": "application/json",
            "Content-Length": Buffer.byteLength(jsonPayload, 'utf8')
        }
    };
    // Send request
    const postRequest = https.request(reqOptions, (response) => {

        response.setEncoding('utf8');

        // Build response body in a string
        let resBody = '';

        // Listen for data and add
        response.on('data', function (chunk) {
            resBody += chunk
        });

        response.on("end", () => {
            // Parse JSON response
            const data = JSON.parse(resBody);
            if (data.error == false) {
                // Download CSV file
                var file = fs.createWriteStream(destinationFile);
                https.get(data.url, (response2) => {
                    response2.pipe(file)
                        .on("close", () => {
                            console.log(`Generated CSV file saved as "${destinationFile}" file.`);
                        });
                });
            }
            else {
                // Service reported error
                console.log("convertPdfToCsv(): " + data.message);
            }
        });
    })
        .on("error", (e) => {
            // Request error
            console.log("convertPdfToCsv(): " + e);
        });

    // Write request data
    postRequest.write(jsonPayload);
    postRequest.end();
}

