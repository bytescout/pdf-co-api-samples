/**
 * Initial Declaration and References
 */
// Get the active spreadsheet and the active sheet
ss = SpreadsheetApp.getActiveSpreadsheet();
ssid = ss.getId();
  
// Look in the same folder the sheet exists in. For example, if this template is in
// My Drive, it will return all of the files in My Drive.
var ssparents = DriveApp.getFileById(ssid).getParents();

// Loop through all the files and add the values to the spreadsheet.
var folder = ssparents.next();


/**
 * Add PDF.co Menus in Google Spreadsheet
 */
function onOpen() {
  var menuItems = [
    {name: 'Merge PDF URLs Listed In Cell', functionName: 'mergePDFDocuments'} 
  ];
  ss.addMenu('PDF.co', menuItems);
}

/**
 * Function which merges documents using PDF.co
 */
function mergePDFDocuments() {

  // Get PDF.co API Key Cell
  const pdfCoAPIKey = ss.getRange("B1").getValue();

  let startingIndex = 4;

  let inputPDFCell = ss.getRange(`A${startingIndex}`);
  let inputPDFUrls = inputPDFCell.getValue();
  let resultUrlCell = ss.getRange(`B${startingIndex}`);
  let hasInputUrls = inputPDFUrls !== "";

  while(hasInputUrls){
    process_mergeingPDFDocuments(inputPDFCell, resultUrlCell, pdfCoAPIKey);

    startingIndex += 1;
    inputPDFCell = ss.getRange(`A${startingIndex}`);
    inputPDFUrls = inputPDFCell.getValue();
    resultUrlCell = ss.getRange(`B${startingIndex}`);
    hasInputUrls = inputPDFUrls !== ""
  }
}

/**
 * Function which merges documents using PDF.co
 */
function process_mergeingPDFDocuments(inputPDFCell, resultUrlCell, pdfCoAPIKey) {

  let pdfUrl = inputPDFCell.getValue();
  
  // Prepare Payload
  var data = {
    "async": true, // As we have large volumn of PDF files, Enabling async mode
    "name": `result_${uuidv4()}`, // Random unique name
    "url": pdfUrl
  };

  // Prepare Request Options
  var options = {
    'method' : 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
    // Convert the JavaScript object to a JSON string.
    'payload' : JSON.stringify(data)
  };
  
  // Get Response
  // https://developers.google.com/apps-script/reference/url-fetch
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/merge', options);

  var pdfCoRespContent = pdfCoResponse.getContentText();
  var pdfCoRespJson = JSON.parse(pdfCoRespContent);

  if(pdfCoRespJson.error){
    resultUrlCell.setValue(pdfCoRespJson.message);    
  }
  else{
    // Job Success Callback
    const successCallbackFn = function(){
      // Upload file to Google Drive
      uploadFile(pdfCoRespJson.url);

      // Update Cell with result URL
      resultUrlCell.setValue(pdfCoRespJson.url);    
    }

    // Check PDF.co Job Status
    checkPDFcoJobStatus(pdfCoRespJson.jobId, pdfCoAPIKey, successCallbackFn);
  }
}

/**
 * Checks PDF.co Job Status
 */
function checkPDFcoJobStatus(jobId, pdfCoAPIKey, successCallbackFn){
  // Prepare Payload
  const data = {
    "jobid": jobId
  };

 // Prepare Request Options
  const options = {
    'method' : 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
    // Convert the JavaScript object to a JSON string.
    'payload' : JSON.stringify(data)
  };

  // Get Response
  // https://developers.google.com/apps-script/reference/url-fetch
  const resp = UrlFetchApp.fetch('https://api.pdf.co/v1/job/check', options);

  // Response Json
  const respJson = JSON.parse(resp.getContentText());

  
  if(respJson.status === "working"){
    // Pause for 3 seconds
    Utilities.sleep(3 * 1000);

    // And check Job again
    checkPDFcoJobStatus(jobId, pdfCoAPIKey, successCallbackFn);
  }
  else if(respJson.status == "success"){
    // Invoke Success Callback Function 
    successCallbackFn();
  }
  else {
    console.error(`Job Failed with status ${respJson.status}`);
  }
}


/**
 * Save file URL to specific location
 */
function uploadFile(fileUrl) {
  var fileContent = UrlFetchApp.fetch(fileUrl).getBlob();
  folder.createFile(fileContent);
}

function uuidv4() {
  var d = new Date().getTime();//Timestamp
    var d2 = ((typeof performance !== 'undefined') && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random() * 16;//random number between 0 and 16
        if(d > 0){//Use timestamp until depleted
            r = (d + r)%16 | 0;
            d = Math.floor(d/16);
        } else {//Use microseconds since page-load if supported
            r = (d2 + r)%16 | 0;
            d2 = Math.floor(d2/16);
        }
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
}

