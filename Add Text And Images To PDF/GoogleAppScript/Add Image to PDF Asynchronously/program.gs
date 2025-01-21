// Handle PDF.co Menu on Google Sheet Open Event
function onOpen() {
  var spreadsheet = SpreadsheetApp.getActive();
  var menuItems = [
    {name: 'CreatePDF', functionName: 'addImageToPDF'}
  ];
  spreadsheet.addMenu('PDF.co', menuItems);
}


/**
 * A function that adds headers and some initial data to the spreadsheet.
 */
function addImageToPDF() {
  var spreadsheet = SpreadsheetApp.getActive();


  // Get PDF.co API Key Cell
  let pdfCoAPIKeyCell = spreadsheet.getRange("B1");


  // Get Cells for Input/Output
  let pdfUrlCell = spreadsheet.getRange("A4");
  let imageUrlCell = spreadsheet.getRange("B4");
  let resultUrlCell = spreadsheet.getRange("C4");


  let pdfCoAPIKey = pdfCoAPIKeyCell.getValue();
  let pdfUrl = pdfUrlCell.getValue();
  let imageUrl = imageUrlCell.getValue();
 
  // Prepare Payload
  var data = {
    "async": true, // Enable asynchronous processing
    "encrypt": false,
    "inline": true,
    "name": "sample_result",
    "url": pdfUrl,
    "imagesString": `345;57;0-;${imageUrl}`
  };


  // Prepare Request Options
  var options = {
    'method' : 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
    'payload' : JSON.stringify(data)
  };
 
  // Send the request to PDF.co API
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/edit/add', options);


  var pdfCoRespContent = pdfCoResponse.getContentText();
  var pdfCoRespJson = JSON.parse(pdfCoRespContent);


  // Handle the asynchronous response
  if (!pdfCoRespJson.error) {
    var jobId = pdfCoRespJson.jobId;
   
    // Log job creation
    Logger.log(`Job #${jobId} created. Checking status...`);


    // Check the job status periodically until the job completes
    checkJobStatus(jobId, pdfCoAPIKey, resultUrlCell);
  } else {
    resultUrlCell.setValue(pdfCoRespJson.message);
  }
}


function checkJobStatus(jobId, pdfCoAPIKey, resultUrlCell) {
  // Prepare Payload for Job Status Check
  var data = {
    "jobid": jobId
  };


  // Prepare Request Options
  var options = {
    'method' : 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
    'payload' : JSON.stringify(data)
  };


  // Send the request to check job status
  var jobResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/job/check', options);


  var jobRespContent = jobResponse.getContentText();
  var jobRespJson = JSON.parse(jobRespContent);


  // Log the status check with time
  Logger.log(`Job #${jobId} Status: ${jobRespJson.status}, Time: ${new Date().toLocaleString()}`);


  if (jobRespJson.status === "working") {
    // Job is still processing; check again after 3 seconds
    Utilities.sleep(3000);
    checkJobStatus(jobId, pdfCoAPIKey, resultUrlCell);
  } else if (jobRespJson.status === "success") {
    // Job is complete; get the result URL
    var resultFileUrl = jobRespJson.url;


    // Log the generated result URL
    Logger.log(`Generated PDF file is available at: ${resultFileUrl}`);


    // Set the result URL in the sheet
    resultUrlCell.setValue(resultFileUrl);
  } else {
    // Handle any errors or unsuccessful job status
    resultUrlCell.setValue(`Operation ended with status: ${jobRespJson.status}`);
  }
}
