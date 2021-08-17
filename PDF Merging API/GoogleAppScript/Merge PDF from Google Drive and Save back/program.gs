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
    {name: 'Get All PDF From Current Folder', functionName: 'getPDFFilesFromCurFolder'},
    {name: 'Merge PDF URLs Listed In Cell', functionName: 'mergePDFDocuments'} 
  ];
  ss.addMenu('PDF.co', menuItems);
}


/**
 * Get all PDF files from current folder
 */
function getPDFFilesFromCurFolder() {
  var files = folder.getFiles();
  var pdfUrlCell = ss.getRange("A4"); 

  var allFileUrls = [];

  while (files.hasNext()) {
    var file = files.next();

    var fileName = file.getName();
    if(fileName.endsWith(".pdf")){
      // Make File Pulblic accessible with URL so that it can be accessible with external API
      var resource = {role: "reader", type: "anyone"};
      Drive.Permissions.insert(resource, file.getId());

      // Add Url
      allFileUrls.push(file.getDownloadUrl());
    }

    pdfUrlCell.setValue(allFileUrls.join(","));
  }   
}


/**
 * Function which merges documents using PDF.co
 */
function mergePDFDocuments() {

  // Get PDF.co API Key Cell
  let pdfCoAPIKeyCell = ss.getRange("B1");

  // Get Cells for Input/Output
  let pdfUrlCell = ss.getRange("A4"); 
  let resultUrlCell =  ss.getRange("B4");

  let pdfCoAPIKey = pdfCoAPIKeyCell.getValue();
  let pdfUrl = pdfUrlCell.getValue();
  
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
}


/**
 * Save file URL to specific location
 */
function uploadFile(fileUrl) {
  var fileContent = UrlFetchApp.fetch(fileUrl).getBlob();
  folder.createFile(fileContent);
}
