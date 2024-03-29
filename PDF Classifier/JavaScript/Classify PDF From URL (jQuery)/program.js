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


var settings = {
    "url": "https://api.pdf.co/v1/pdf/classifier",
    "method": "POST",
    "timeout": 0,
    "headers": {
            "Content-Type": "application/json",
            "x-api-key": "YOUR_PDFCO_API_KEY"
    },
    "data": JSON.stringify({
      "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf",
      "async": false,
      "encrypt": "false",
      "inline": "true",
      "password": "",
      "profiles": ""
    }),
};

$.ajax(settings).done(function (response) {
    console.log(response);
});
