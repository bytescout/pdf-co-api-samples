/**
 * IMPORTANT: Add Service reference for "Drive". Go to Services > Locate "Drive (drive API)" > Add Reference of it 
 */

// Add Your PDF.co API Key here
const pdfCoAPIKey = 'ADD_YOUR_PDFCo_API_KEY_HERE';

// Password
const pdfPassword = "Hello12345";

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
  var allFolders = DriveApp.getFoldersByName("Folder_Containing_PDF_Files");
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
    {name: 'Add Password to All PDF Files Of Current Folder', functionName: 'addPasswordToCurrentFolderPDFs'} 
  ];
  ss.addMenu('PDF.co', menuItems);
}

function addPasswordToCurrentFolderPDFs(){
  var allFileNameUrls = getPDFFilesFromCurFolder();
  var allResp = [];

  if(allFileNameUrls && allFileNameUrls.length > 0){
    for(let i = 0; i < allFileNameUrls.length; i++){
      const elmCurFileNameUrl = allFileNameUrls[i];

      var oResp = addPasswordToPDF(elmCurFileNameUrl.url, elmCurFileNameUrl.fileName);
      allResp.push(oResp);
    }
  }

  // Write all resp
  let resultUrlCell =  ss.getRange("A1");
  
  // Update Cell with result
  resultUrlCell.setValue(allResp.join("\n\r"));    
}

/**
 * Get all PDF files from current folder
 */
function getPDFFilesFromCurFolder() {
  var files = folder.getFiles();
  var allFileNameUrls = [];

  while (files.hasNext()) {
    var file = files.next();

    var fileName = file.getName();
    if(fileName.endsWith(".pdf") && !fileName.includes("_protected")){
      // Create Pre-Signed URL from PDF.co
      var respPresignedUrl = getPDFcoPreSignedURL(fileName)

      if(!respPresignedUrl.error){
        var fileData = file.getBlob();
        if(uploadFileToPresignedURL(respPresignedUrl.presignedUrl, fileData)){
          // Add Url
          allFileNameUrls.push({url: respPresignedUrl.url, fileName: fileName});
        }
      }
    }
  }

  return allFileNameUrls;
}

/**
 * Merges PDF URLs using PDF.co and Save to drive
 */
function addPasswordToPDF(pdfUrl, pdfFileName) {
  // Output File Name
  let outputFileName = `${pdfFileName.replace('.pdf','')}_protected.pdf`;
  
  // Prepare Payload
  var data = {
    "url": pdfUrl,
    "ownerPassword": pdfPassword,
    "userPassword": pdfPassword,
    "EncryptionAlgorithm": "AES_128bit",
    "AllowPrintDocument": false,
    "AllowFillForms": false,
    "AllowModifyDocument": false,
    "AllowContentExtraction": false,
    "AllowModifyAnnotations": false,
    "PrintQuality": "LowResolution",
    "encrypt": false,
    "async": false,
    "name": outputFileName
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
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/security/add', options);

  var pdfCoRespContent = pdfCoResponse.getContentText();
  var pdfCoRespJson = JSON.parse(pdfCoRespContent);

  // Display Result
  if(!pdfCoRespJson.error){
    // Upload file to Google Drive
    uploadFile(pdfCoRespJson.url);

    return `Added Password to ${pdfFileName} and Saved as ${outputFileName}`;
  }
  else{
    return `Error Protecting ${pdfFileName}`;
  }
}

/**
 * Gets PDF.co Presigned URL
 */
function getPDFcoPreSignedURL(fileName){
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
function uploadFileToPresignedURL(presignedUrl, fileContent){
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
 * Save file URL to specific location
 */
function uploadFile(fileUrl) {
  var fileContent = UrlFetchApp.fetch(fileUrl).getBlob();
  folder.createFile(fileContent);
}
