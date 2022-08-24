/**
 * IMPORTANT: Add Service reference for "Drive". Go to Services > Locate "Drive (drive API)" > Add Reference of it 
 */

// Add Your PDF.co API Key here
const pdfCoAPIKey = 'PDFco_API_Key_Here';

// Get the active spreadsheet and the active sheet
ss = SpreadsheetApp.getActiveSpreadsheet();
ssid = ss.getId();

// Look in the same folder the sheet exists in. For example, if this template is in
// My Drive, it will return all of the files in My Drive.
var ssparents = DriveApp.getFileById(ssid).getParents();

// Store File-Ids/PermissionIds used for merging
let filePermissions = [];

/**
 * Note: Here, we're getting current folder where spreadsheet is residing.
 * But we can certainly pick any folder of our like by using Folder related functions.
 * For example:
  var allFolders = DriveApp.getFoldersByName("Google App Merge Demo - Private File");
  while (allFolders.hasNext()) {
    var folder = allFolders.next();
    Logger.log(folder.getName());
  }
 */
// Loop through all the files and add the values to the spreadsheet.
var folder = ssparents.next();

/**
 * Add PDF.co Menus in Google Spreadsheet
 */
function onOpen() {
  var menuItems = [
    {name: 'Merge All Files From Current Folder', functionName: 'mergePDFDocumentsFromCurrentFolder'} 
  ];
  ss.addMenu('PDF.co', menuItems);
}

function mergePDFDocumentsFromCurrentFolder(){
  var allFilesLink = getPDFFilesFromCurFolder(pdfCoAPIKey);
  mergePDFDocuments(allFilesLink, pdfCoAPIKey);
}

/**
 * Get all PDF files from current folder
 */
function getPDFFilesFromCurFolder(pdfCoAPIKey) {
  var files = folder.getFiles();
  var allFileUrls = [];

  while (files.hasNext()) {
    var file = files.next();

    var fileName = file.getName();
    if(fileName.endsWith(".pdf")){
      // Create Pre-Signed URL from PDF.co
      var respPresignedUrl = getPDFcoPreSignedURL(fileName, pdfCoAPIKey)

      if(!respPresignedUrl.error){
        var fileData = file.getBlob();
        if(uploadFileToPresignedURL(respPresignedUrl.presignedUrl, fileData, pdfCoAPIKey)){
          // Add Url
          allFileUrls.push(respPresignedUrl.url);
        }
      }
    }
  }

  return allFileUrls.join(",");
}

/**
 * Merges PDF URLs using PDF.co and Save to drive
 */
function mergePDFDocuments(pdfUrl, pdfCoAPIKey) {

  // Get Cells for Input/Output
  let resultUrlCell =  ss.getRange("A4");
  
  // Prepare Payload
  var data = {
    "async": true, // As we have large volumn of PDF files, Enabling async mode
    "name": "result",
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
    checkPDFcoJobStatus(pdfCoRespJson.jobId, successCallbackFn);
  }
}

/**
 * Gets PDF.co Presigned URL
 */
function getPDFcoPreSignedURL(fileName, pdfCoAPIKey){
  // Prepare Request Options
  var options = {
    'method' : 'GET',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    }
  };

  var apiUrl = `https://api.pdf.co/v1/file/upload/get-presigned-url?name=${fileName}`;
  
  // Get Response
  // https://developers.google.com/apps-script/reference/url-fetch
  var pdfCoResponse = UrlFetchApp.fetch(apiUrl, options);

  var pdfCoRespContent = pdfCoResponse.getContentText();
  var pdfCoRespJson = JSON.parse(pdfCoRespContent);

  return pdfCoRespJson;
}

/**
 * Uploads File to PDF.co PreSigned URL
 */
function uploadFileToPresignedURL(presignedUrl, fileContent, pdfCoAPIKey){
  // Prepare Request Options
  var options = {
    'method' : 'PUT',
    'contentType': 'application/octet-stream',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
    // Convert the JavaScript object to a JSON string.
    'payload' : fileContent
  };
  
  // Get Response
  // https://developers.google.com/apps-script/reference/url-fetch
  var pdfCoResponse = UrlFetchApp.fetch(presignedUrl, options);

  if(pdfCoResponse.getResponseCode() === 200){
    return true;
  }
  else{
    return false;
  }
}


/**
 * Checks PDF.co Job Status
 */
function checkPDFcoJobStatus(jobId, successCallbackFn){
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
    checkPDFcoJobStatus(jobId, successCallbackFn);
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
