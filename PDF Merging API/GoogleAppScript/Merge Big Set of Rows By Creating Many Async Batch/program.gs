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
const HowManyRows = 3000;
const HowManyColumns = 1;
const BatchSize = 100;

let allBatches = [];

/**
 * Add PDF.co Menu in Google Spreadsheet
 */
function onOpen() {
  var menuItems = [
    {name: 'Merge All Rows', functionName: 'handleMergeAllRowsMenuClick'}
  ];
  SpreadsheetApp.getActiveSpreadsheet().addMenu('PDF.co', menuItems);
}

/**
 * Handle Menu click
 */
function handleMergeAllRowsMenuClick(){
  // STEP 1 - Get all Rows URL comma seperated
  allBatches = getAllPDFFileURLsCommaSeperated();

  // STEP 2 - Perform Merge and save output File
  mergePDFDocumentsUsingPDFco();
}

/**
 * Get all Rows URL into comma-seperated form  
 */
function getAllPDFFileURLsCommaSeperated(){
  // We can customize Rows fetching logic as per our requirement.
  // See https://jeffreyeverhart.com/2019/03/01/retrieve-rows-from-google-spreadsheet-with-google-apps-script/ 

  // Get all Rows
  const rows = SpreadsheetApp.getActiveSheet().getRange(StartingRow, StartingColumn, HowManyRows, HowManyColumns).getValues();

  // Filter Rows with blank values
  const filterRows = rows.filter(row => row.toString().trim() !== "");

  let retBatches = [];

  let _batchCounter = 1;
  let _tempBatch = [];

  for(let i = 0; i < filterRows.length; i++){
    
    if(_batchCounter > BatchSize){
      retBatches.push({ batch: _tempBatch, jobId: '', isComplete: false, outputUrl: '' });
      _tempBatch = [];
      _batchCounter = 1;
    }

    _tempBatch.push(filterRows[i]);
    _batchCounter++;
 }

 if(_tempBatch.length > 0){
   retBatches.push({ batch: _tempBatch, jobId: '', isComplete: false, outputUrl: '' });
 }

 return retBatches;
}

/**
 * Perform File Merge using PDF.co
 */
function mergePDFDocumentsUsingPDFco(){

  if(allBatches.length ==  0){ return; }

  // Create JobId for Batch
  for(var i = 0; i < allBatches.length; i++){
    _createBatchMergeOperationJob(allBatches[i]);
  }

  // Get into infinite loop, until all batch are processed
  while(true){
    // Don't break until Batch Job is completed
    if(allBatches.some(x => !x.isComplete)){
      // Pause for 3 seconds
      Utilities.sleep(3 * 1000);
  
      _checkAllJobStatus();
    }
    else{
      break;
    }
  }

  // At this stage we have all Batches completed
  // Perform Final Merge
  const commaSeperatedBatchOutputURLs = allBatches.filter(x => x.outputUrl != "").map(x => x.outputUrl).join(',');

  const finalMergeResp =  createMergeRequest(commaSeperatedBatchOutputURLs);

  // Loop until Job is completed
  while(true){
    const jobResp = checkPDFcoJobStatus(finalMergeResp.jobId);

    if(jobResp.status === 'working'){
      // Pause for 3 seconds
      Utilities.sleep(3 * 1000);
    }
    else{
      if(jobResp.status === 'success'){
        // Console log 
        console.log(`Final URL: ${jobResp.url}`);

        // Upload file to Google Drive
        saveURLToCurrentFolder(jobResp.url);
      }
      else{
        console.error(`Job Errored Out: ${jobResp.status}, ${jobResp.message}`)
      }

      // Break Loop
      break;
    }
  }
}

function _createBatchMergeOperationJob(batchRow){
  const allURLs = batchRow.batch.join(',');

  const callbackFn = function(respJson){
    if(respJson.error){
      batchRow.isComplete = true;
      console.error(respJson.message);
    }
    else{
      // Response JobId
      batchRow.jobId = respJson.jobId;
    }
  };

  createMergeRequest(allURLs, callbackFn)
}


function _checkAllJobStatus(){
  for(var i = 0; i < allBatches.length; i++){
    let curBatch = allBatches[i];

    if(!curBatch.isComplete){

      const callbackFn = function(respJob){
        curBatch.status = respJob.status;

        if(respJob.status === 'success'){
          curBatch.outputUrl = respJob.url;
          curBatch.isComplete = true;
        }
        else if(respJob.status !== 'working'){ // error out
          curBatch.isError = true;
          curBatch.isComplete = true;
        }
      }

      checkPDFcoJobStatus(curBatch.jobId, callbackFn)
    }
  }
}

function createMergeRequest(allURLs, callbackFn){
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

  if(typeof callbackFn === 'function'){
    callbackFn(respJson);
  }

  return respJson;
}


/**
 * Checks PDF.co Job Status
 */
function checkPDFcoJobStatus(jobId, callbackFn){
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

  if(typeof callbackFn === 'function'){
    // Invoke Callback function
    callbackFn(respJson);
  }

  return respJson;
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
