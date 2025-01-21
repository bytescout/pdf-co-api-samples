//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
//                                                                                           //
//*******************************************************************************************//


var https = require("https");

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co
const API_KEY = "***********************************";

// Direct URL of source PDF file.
// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
const SourceFileUrl = "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-security/ProtectedPDFFile.pdf";

// The owner/user password to open file and to remove security features
const PDFFilePassword = "admin@123";

// Runs processing asynchronously. 
// Returns Use JobId that you may use with /job/check to check state of the processing (possible states: working, failed, aborted and success).
const async = false;

// Prepare request to `PDF Security` API endpoint
var queryPath = `/v1/pdf/security/remove`;

// JSON payload for api request
var jsonPayload = JSON.stringify({
    name: 'unprotected.pdf',
    url: SourceFileUrl,
    password: PDFFilePassword,
    async: async
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

exports.handler = async (event) => {

    let dataString = '';
    const promise_response = await new Promise((resolve, reject) => {
        
        // Send request
        var postRequest = https.request(reqOptions, (response) => {
            response.on('data', chunk => {
                dataString += chunk;
            });
            
            response.on('end', () => {
                resolve({
                    statusCode: 200,
                    body: JSON.stringify(JSON.parse(dataString), null, 4)
                });
            });
              
        }).on("error", (e) => {
            reject({
                statusCode: 500,
                body: 'Something went wrong!'
            });
        });
        
        // Write request data
        postRequest.write(jsonPayload);
        postRequest.end();
    });

    return promise_response;
};
