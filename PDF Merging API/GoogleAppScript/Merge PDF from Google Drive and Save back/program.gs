/**
 * Initial Declaration and References
 */
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
  var allFolders = DriveApp.getFoldersByName("Google Drive Folder Name");
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
  var allFilesLink = getPDFFilesFromCurFolder();
  mergePDFDocuments(allFilesLink);
}

/**
 * Get all PDF files from current folder
 */
function getPDFFilesFromCurFolder() {
  var files = folder.getFiles();
  var allFileUrls = [];

  while (files.hasNext()) {
    var file = files.next();

    var fileName = file.getName();
    if(fileName.endsWith(".pdf")){
      // Make File Pulblic accessible with URL so that it can be accessible with external API
      makeFilePublicallyAccessible(file.getId());

      // Add Url
      allFileUrls.push(file.getDownloadUrl());
    }
  }

  return allFileUrls.join(",");
}

/**
 * Function to make file publically accessible
 */
function makeFilePublicallyAccessible(fileId){
  // Make File Pulblic accessible with URL so that it can be accessible with external API
  var resource = {role: "reader", type: "anyone"};
  var respPermission = Drive.Permissions.insert(resource, fileId);

  filePermissions.push({FileId: fileId, PermissionId: respPermission.id});
}

/**
 * Function to make file private again
 */
function revokeAllPermissions(){
  if(filePermissions && filePermissions.length > 0){
    for(var i = 0; i < filePermissions.length; i++){
      Drive.Permissions.remove(filePermissions[i].FileId, filePermissions[i].PermissionId);
    }
  }
}


/**
 * Function which merges documents using PDF.co
 */
function mergePDFDocuments(pdfUrl) {

  // Get PDF.co API Key Cell
  let pdfCoAPIKeyCell = ss.getRange("B1");

  // Get Cells for Input/Output
  let resultUrlCell =  ss.getRange("A4");

  let pdfCoAPIKey = pdfCoAPIKeyCell.getValue();
  
  // Prepare Payload
  var data = {
    "async": false,
    "encrypt": false,
    "inline": true,
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

  // Display Result
  if(!pdfCoRespJson.error){
    // Upload file to Google Drive
    uploadFile(pdfCoRespJson.url);

    // Update Cell with result URL
    resultUrlCell.setValue(pdfCoRespJson.url);    
  }
  else{
    resultUrlCell.setValue(pdfCoRespJson.message);    
  }

  // Revoke All Permissins
  revokeAllPermissions();
}


/**
 * Save file URL to specific location
 */
function uploadFile(fileUrl) {
  var fileContent = UrlFetchApp.fetch(fileUrl).getBlob();
  folder.createFile(fileContent);
}
