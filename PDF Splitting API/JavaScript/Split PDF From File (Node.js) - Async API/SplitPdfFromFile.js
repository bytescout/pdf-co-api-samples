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
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Source PDF file to split
const SourceFile = "./sample.pdf";
// Comma-separated list of page numbers (or ranges) to process. Example: '1,3-5,7-'.
const Pages = "1-2,3-";


// Prepare request to `Split PDF Pages` API endpoint
var query = `https://api.pdf.co/v1/pdf/split`;
let reqOptions = {
    uri: query,
    headers: { "x-api-key": API_KEY },
    formData: {
        pages: Pages,
        async: 'True',
        file: fs.createReadStream(SourceFile)
    },
};

// Send request
request.post(reqOptions, function (error, response, body) {
    if (error) {
        return console.error("Error: ", error);
    }

    // Parse JSON response
    let data = JSON.parse(body);
    console.log(`Job #${data.jobId} has been created!`);
    checkIfJobIsCompleted(data.jobId, data.url);
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
            console.log(`Checking Job #${jobId}, Status: ${data.status}, Time: ${new Date().toLocaleString()}`);

            if (data.status == "working") {
                // Check again after 3 seconds
                setTimeout(function () { checkIfJobIsCompleted(jobId, resultFileUrlJson) }, 3000);
            }
            else if (data.status == "success") {

                request({ method: 'GET', uri: resultFileUrlJson, gzip: true },
                    function (error, response, body) {

                        //* workaround for issue with non supoprted firstchar code
                        var firstCharCode = body.charCodeAt(0);
                        if (firstCharCode == 65279) {
                            body = body.substring(1);
                        }

                        // Parse JSON response
                        let respJsonFileArray = JSON.parse(body);
                        let part = 1;

                        respJsonFileArray.forEach((url) => {
                            var localFileName = `./part${part}.pdf`;
                            var file = fs.createWriteStream(localFileName);
                            https.get(url, (response2) => {
                                response2.pipe(file)
                                    .on("close", () => {
                                        console.log(`Generated PDF file saved as "${localFileName} file."`);
                                    });
                            });
                            part++;
                        }, this);

                    });
            }
            else {
                console.log(`Operation ended with status: "${data.status}".`);
            }
        })
    });
}
