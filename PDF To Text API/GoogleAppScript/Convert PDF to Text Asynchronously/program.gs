// Handle PDF.co Menu on Google Sheet Open Event
function onOpen() {
  var spreadsheet = SpreadsheetApp.getActive();
  var menuItems = [
    {name: 'CreatePDF', functionName: 'addTextAnnotationToPDF'}
  ];
  spreadsheet.addMenu('PDF.co', menuItems);
}


/**
 * A function that adds headers and some initial data to the spreadsheet.
 */
function addTextAnnotationToPDF() {
  var spreadsheet = SpreadsheetApp.getActive();


  // Get PDF.co API Key Cell
  let pdfCoAPIKeyCell = spreadsheet.getRange("B1");


  // Get Cells for Input/Output
  let pdfUrlCell = spreadsheet.getRange("A4");
  let imageUrlCell = spreadsheet.getRange("B4");
  let resultUrlCell =  spreadsheet.getRange("C4");


  let pdfCoAPIKey = pdfCoAPIKeyCell.getValue();
  let pdfUrl = pdfUrlCell.getValue();
  let imageUrl = imageUrlCell.getValue();
 
  // Prepare Payload
  var data = {
    "async": true, // Enable async processing
    "encrypt": false,
    "inline": true,
    "name": "sample_result",
    "url": pdfUrl,
    "annotationsString": `250;20;0-;${imageUrl};24+bold+italic+underline+strikeout;Arial;FF0000;www.pdf.co;true`
  };


  // Prepare Request Options
  var options = {
    'method': 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
    // Convert the JavaScript object to a JSON string.
    'payload': JSON.stringify(data)
  };
 
  // Send Initial Request to Create Job
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/edit/add', options);
  var pdfCoRespJson = JSON.parse(pdfCoResponse.getContentText());


  if (!pdfCoRespJson.error) {
    Logger.log(`Job #${pdfCoRespJson.jobId} created. Checking status...`);
    checkIfJobIsCompleted(pdfCoAPIKey, pdfCoRespJson.jobId, pdfCoRespJson.url, resultUrlCell);
  } else {
    resultUrlCell.setValue(pdfCoRespJson.message);
  }
}


/**
 * Function to check if the job is completed
 */
function checkIfJobIsCompleted(apiKey, jobId, resultFileUrl, resultUrlCell) {
  var queryPath = 'https://api.pdf.co/v1/job/check';


  var data = {
    "jobid": jobId
  };


  var options = {
    'method': 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": apiKey
    },
    'payload': JSON.stringify(data)
  };


  // Make Request
  var response = UrlFetchApp.fetch(queryPath, options);
  var jsonResponse = JSON.parse(response.getContentText());


  Logger.log(`Job #${jobId} Status: ${jsonResponse.status}, Time: ${new Date().toLocaleString()}`);


  if (jsonResponse.status === "working") {
    // Check again after 3 seconds
    Utilities.sleep(3000);
    checkIfJobIsCompleted(apiKey, jobId, resultFileUrl, resultUrlCell);
  } else if (jsonResponse.status === "success") {
    // Set result URL in the spreadsheet
    resultUrlCell.setValue(resultFileUrl);
    Logger.log(`Generated PDF file is available at: ${resultFileUrl}`);
  } else {
    resultUrlCell.setValue(`Operation ended with status: "${jsonResponse.status}".`);
    Logger.log(`Operation ended with status: "${jsonResponse.status}".`);
  }
}
