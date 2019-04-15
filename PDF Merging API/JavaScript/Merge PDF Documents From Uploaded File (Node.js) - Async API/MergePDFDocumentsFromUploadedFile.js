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
const SourceFile1 = "./sample1.pdf";
const SourceFile2 = "./sample2.pdf";

// Destination PDF file name
const DestinationFile = "./result.pdf";

// Upload File-1: - 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.
getPresignedUrl(SourceFile1)
    .then(([uploadUrl1, uploadedFileUrl1]) => {

        // Upload File-1: - 2. UPLOAD THE FILE TO CLOUD.
        uploadFile(SourceFile1, uploadUrl1)
            .then(() => {

                // Upload File-2: - 1. RETRIEVE PRESIGNED URL TO UPLOAD FILE.
                getPresignedUrl(SourceFile2)
                    .then(([uploadUrl2, uploadedFileUrl2]) => {

                        // Upload File-2: - 2. UPLOAD THE FILE TO CLOUD.
                        uploadFile(SourceFile2, uploadUrl2)
                            .then(() => {

                                const SourceFiles = [
                                    uploadedFileUrl1,
                                    uploadedFileUrl2
                                ];

                                // Perform Merge PDF Documents
                                mergePDFDocuments(SourceFiles, DestinationFile);
                            })
                            .catch(e => {
                                console.log(e);
                            });
                    })
                    .catch(e => {
                        console.log(e);
                    });
            })
            .catch(e => {
                console.log(e);
            });
    })
    .catch(e => {
        console.log(e);
    });


function getPresignedUrl(localFile) {
    return new Promise(resolve => {
        // Prepare request to `Get Presigned URL` API endpoint
        let queryPath = `/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=${path.basename(localFile)}`;
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

function uploadFile(sourceFile, uploadUrl) {
    return new Promise(resolve => {
        fs.readFile(sourceFile, (err, data) => {
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

function mergePDFDocuments(SourceFiles, DestinationFile) {
    // Prepare request to `Merge PDF` API endpoint
    var queryPath = `/v1/pdf/merge?name=${path.basename(DestinationFile)}&url=${SourceFiles.join(",")}&async=True`;
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
        console.log(e);
    });
}

function checkIfJobIsCompleted(jobId, resultFileUrl) {
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
				setTimeout(function(){ checkIfJobIsCompleted(jobId, resultFileUrl);}, 3000);
            }
            else if (data.Status == "Finished") {
                // Download PDF file
                var file = fs.createWriteStream(DestinationFile);
                https.get(resultFileUrl, (response2) => {
                    response2.pipe(file)
                        .on("close", () => {
                            console.log(`Generated PDF file saved as "${DestinationFile}" file.`);
                        });
                });
            }
            else {
                console.log(`Operation ended with status: "${data.Status}".`);
            }
        })
    });
}
