/**
 * IMPORTANT: Add Service reference for "Drive". Go to Services > Locate "Drive (drive API)" > Add Reference of it 
 */

// Add Your PDF.co API Key here
const pdfCoAPIKey = 'Enter_Your_PDFco_API_Key';

// Output file Name
const resultFileName = "result.pdf"

// Rows to fetch
const StartingRow = 1;
const StartingColumn = 1;
const HowManyRows = 432;
const HowManyColumns = 1;

// Output Cells
const JobIdCellAddress = 'D1';
const JobStatusCellAddress = 'D2';
const JobOutputURLCellAddress = 'D3';

/**
 * Add PDF.co Menu in Google Spreadsheet
 */
function onOpen() {
  var menuItems = [
    {name: 'Create Job to Merge All Rows', functionName: 'handleMergeAllRowsMenuClick'},
    {name: 'Check Job Status', functionName: 'handleCheckJobStatus'} 
  ];
  SpreadsheetApp.getActiveSpreadsheet().addMenu('PDF.co', menuItems);
}

/**
 * Handle Menu click
 */
function handleMergeAllRowsMenuClick(){
  // STEP 1 - Get all Rows URL comma seperated
  var allFilesCommaSeperated = getAllPDFFileURLsCommaSeperated();

  // STEP 2 - Perform Merge and save output File
  mergePDFDocumentsUsingPDFco(allFilesCommaSeperated);
}


/**
 * Handle Check Job Status
 */
function handleCheckJobStatus(){
    checkPDFcoJobStatus();
}


/**
 * Get all Rows URL into comma-seperated form  
 */
function getAllPDFFileURLsCommaSeperated(){
  // We can customize Rows fetching logic as per our requirement.
  // See https://jeffreyeverhart.com/2019/03/01/retrieve-rows-from-google-spreadsheet-with-google-apps-script/ 

  // Get all Rows
  var rows = SpreadsheetApp.getActiveSheet().getRange(StartingRow, StartingColumn, HowManyRows, HowManyColumns).getValues();

  // Filter Rows with blank values
  var filterRows = rows.filter(row => row.toString().trim() !== "");

  // Return Comma-Seperated Values
  return filterRows.join();
}

/**
 * Perform File Merge using PDF.co
 */
function mergePDFDocumentsUsingPDFco(allURLs){

  // Prepare Payload
  const data = {
    "async": true, // As we have large volumn of PDF files, Enabling async mode
    "name": resultFileName,
    "url": allURLs
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
  const resp = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/merge', options);

  // Response Json
  const respJson = JSON.parse(resp.getContentText());

  if(respJson.error){
    console.error(respJson.message);
  }
  else{

    // Set JobId into cell
    SpreadsheetApp.getActiveSheet().getRange(JobIdCellAddress).setValue(respJson.jobId);

    handleCheckJobStatus();
  }
}

/**
 * Checks PDF.co Job Status
 */
function checkPDFcoJobStatus(){

  const jobId = SpreadsheetApp.getActiveSheet().getRange(JobIdCellAddress).getValue();

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

  // Show Job Status
  SpreadsheetApp.getActiveSheet().getRange(JobStatusCellAddress).setValue(`${respJson.status}, Checked On: ${new Date()}`);

  if(respJson.status == "success"){
    // Upload file to Google Drive
    saveURLToCurrentFolder(respJson.url);

    // Show Output URL
    SpreadsheetApp.getActiveSheet().getRange(JobOutputURLCellAddress).setValue(respJson.url);
  }
  else if(respJson.status != 'working') { 
    SpreadsheetApp.getActiveSheet().getRange(JobOutputURLCellAddress).setValue(`Job Failed with status ${respJson.status}`);
    console.error(`Job Failed with status ${respJson.status}`);
  }
}

/**
 * Save file URL to specific location
 */
function saveURLToCurrentFolder(fileUrl) {

  // Get current spreadsheet Id
  const ssid = SpreadsheetApp.getActiveSpreadsheet().getId();

  // Look in the same folder the sheet exists in. For example, if this template is in
  // My Drive, it will return all of the files in My Drive.
  const ssparents = DriveApp.getFileById(ssid).getParents();

  // Loop through all the files and add the values to the spreadsheet.
  const folder = ssparents.next();

  // Get URL Blob Content
  var fileContent = UrlFetchApp.fetch(fileUrl).getBlob();

  // Save File there
  folder.createFile(fileContent);
}
