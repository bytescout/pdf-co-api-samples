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
var path = require("path");
var fs = require("fs");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
const API_KEY = "***********************************";

// Direct URL of source PDF file.
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-xml/sample.pdf";
// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";
// PDF document password. Leave empty for unprotected documents.
const Password = "";
// Destination XML file name
const DestinationFile = "./result.xml";

/*
Some of advanced options available through profiles:
(it can be single/double-quoted and contain comments.)
{
	"profiles": [
		{
			"profile1": {
				"SaveImages": "None", // Whether to extract images. Values: "None", "Embed".
				"ImageFormat": "PNG", // Image format for extracted images. Values: "PNG", "JPEG", "GIF", "BMP".
				"SaveVectors": false, // Whether to extract vector objects (vertical and horizontal lines). Values: true / false
				"ExtractInvisibleText": true, // Invisible text extraction. Values: true / false
				"ExtractShadowLikeText": true, // Shadow-like text extraction. Values: true / false
				"LineGroupingMode": "None", // Values: "None", "GroupByRows", "GroupByColumns", "JoinOrphanedRows"
				"ColumnDetectionMode": "ContentGroupsAndBorders", // Values: "ContentGroupsAndBorders", "ContentGroups", "Borders", "BorderedTables"
				"Unwrap": false, // Unwrap grouped text in table cells. Values: true / false
				"ShrinkMultipleSpaces": false, // Shrink multiple spaces in table cells that affect column detection. Values: true / false
				"DetectNewColumnBySpacesRatio": 1, // Spacing ratio that affects column detection.
				"CustomExtractionColumns": [ 0, 50, 150, 200, 250, 300 ], // Explicitly specify columns coordinates for table extraction.
				"CheckPermissions": true, // Ignore document permissions. Values: true / false
			}
		}
	]
}
*/

        // Sample profile that sets advanced conversion options
// Advanced options are properties of XMLExtractor class from ByteScout XML Extractor SDK used in the back-end:
// https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/6f2b5e9c-ba15-f9fe-192b-c3e31ec4a0ee.htm
const Profiles = '{ "profiles": [ { "profile1": { "TrimSpaces": "False", "PreserveFormattingOnTextExtraction": "True", "Unwrap": "True", "ShrinkMultipleSpaces": "True" } } ] }';

// Prepare request to `PDF To XML` API endpoint
var queryPath = `/v1/pdf/convert/to/xml?name=${path.basename(DestinationFile)}&password=${Password}&pages=${Pages}&url=${SourceFileUrl}&profiles=${Profiles}&async=True`;
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

            // Process returned job
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
            console.log(`Checking Job #${jobId}, Status: ${data.status}, Time: ${new Date().toLocaleString()}`);

            if (data.status == "working") {
                // Check again after 3 seconds
                setTimeout(function () {
                    checkIfJobIsCompleted(jobId, resultFileUrl);
                }, 3000);
            }
            else if (data.status == "success") {
                // Download XML file
                var file = fs.createWriteStream(DestinationFile);
                https.get(resultFileUrl, (response2) => {
                    response2.pipe(file)
                        .on("close", () => {
                            console.log(`Generated XML file saved as "${DestinationFile}" file.`);
                        });
                });
            }
            else {
                console.log(`Operation ended with status: "${data.status}".`);
            }
        })
    });
}
