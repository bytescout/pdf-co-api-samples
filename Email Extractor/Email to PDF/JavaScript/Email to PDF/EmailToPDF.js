//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
//                                                                                           //
//*******************************************************************************************//


var request = require('request');

// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
var options = {
  'method': 'POST',
  'url': 'https://api.pdf.co/v1/pdf/convert/from/email',
  'headers': {
    'Content-Type': 'application/json',
    'x-api-key': '{{x-api-key}}'
  },
  formData: {
    'url': 'https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml',
    'embedAttachments': 'true',
    'convertAttachments': 'true',
    'paperSize': 'Letter',
    'name': 'email-with-attachments',
    'async': 'false'
  }
};
request(options, function (error, response) {
  if (error) throw new Error(error);
  console.log(response.body);
});
