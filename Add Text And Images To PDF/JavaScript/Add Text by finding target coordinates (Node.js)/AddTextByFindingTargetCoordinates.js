//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2019 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//


var https = require("https");
var path = require("path");
var fs = require("fs");

// `request` module is required for file upload.
// Use "npm install request" command to install.
var request = require("request");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
//const API_KEY = "***********************************";
const API_KEY = "hirenpatel2236@gmail.com_f5859c8ae9a7bca8";

// Direct URL of source PDF file.
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf";

// Search string. 
const SearchString = 'Notes';

// Prepare URL for PDF text search API call.
// See documentation: https://app.pdf.co/documentation/api/1.0/pdf/find.html
var queryFindText = `https://api.pdf.co/v1/pdf/find`;
let reqOptionsFindText = {
    uri: queryFindText,
    headers: { "x-api-key": API_KEY },
    formData: {
        url: SourceFileUrl,
        searchString: SearchString
    }
};

// Send request
request.get(reqOptionsFindText, function (error, responseFindText, bodyFindText) {
    if (error) {
        return console.error("Error: ", error);
    }

    // Parse JSON response
    let dataFindText = JSON.parse(bodyFindText);
    if (dataFindText.body.length > 0) {
        var element = dataFindText.body[0];
        console.log("Found text " + element["text"] + " at coordinates " + element["left"] + ", " + element["top"]);

        // Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
        const Pages = "";

        // PDF document password. Leave empty for unprotected documents.
        const Password = "";

        // Destination PDF file name
        const DestinationFile = "./result.pdf";

        // Text annotation params
        const Type = "annotation";
        const X = +element["left"];
        const Y = +element["top"] + 25;
        const Text = "Some notes will go here... Some notes will go here.... Some notes will go here.....";
        const FontName = "Times New Roman";
        const FontSize = 12;
        const Color = "FF0000";

        // * Add Text *
        // Prepare request to `PDF Edit` API endpoint
        var queryPath = `/v1/pdf/edit/add?name=${path.basename(DestinationFile)}&password=${Password}&pages=${Pages}&url=${SourceFileUrl}&type=${Type}&x=${X}&y=${Y}&text=${Text}&fontname=${FontName}&size=${FontSize}&color=${Color}`;
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
                    // Download the PDF file
                    var file = fs.createWriteStream(DestinationFile);
                    https.get(data.url, (response2) => {
                        response2.pipe(file).on("close", () => {
                            console.log(`Generated PDF file saved to '${DestinationFile}' file.`);
                        });
                    });
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

    } else {
        console.error("No result found.");
    }
});
