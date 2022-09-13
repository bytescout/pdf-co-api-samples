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


var request = require('request');
var options = {
  'method': 'POST',
  'url': 'https://api.pdf.co/v1/email/send',
  'headers': {
    'Content-Type': 'application/json',
    'x-api-key': 'ADD_YOUR_PDFco_API_KEY'
  },
  body: JSON.stringify({
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf",
    "from": "John Doe <john@example.com>",
    "to": "Partner <partner@example.com>",
    "subject": "Check attached sample pdf",
    "bodytext": "Please check the attached pdf",
    "bodyHtml": "Please check the attached pdf",
    "smtpserver": "smtp.gmail.com",
    "smtpport": "587",
    "smtpusername": "my@gmail.com",
    "smtppassword": "app specific password created as https://support.google.com/accounts/answer/185833",
    "async": false
  })

};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
