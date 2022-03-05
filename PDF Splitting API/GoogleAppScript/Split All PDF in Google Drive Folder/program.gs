function splitPDFDocuments() {
  
  // Set Google Drive Folder ID
  var googleDriveFolderId='YOUR_FOLDER_ID';
  
  // Set PDF.co API Key
  var pdfCoAPIKey='YOUR_API_KEY';

  // Get Files from Google Drive Folder
  var files = DriveApp.getFolderById(googleDriveFolderId).getFiles()

  while (files.hasNext()) {
    var file = files.next();
    
    file.setSharing(DriveApp.Access.ANYONE_WITH_LINK, DriveApp.Permission.VIEW);
  };

  // Prepare Payload
  var data = {
    "async": false,
    "encrypt": false,
    "inline": true,
    "name": "result",
    "url": file.getDownloadUrl(),
    "pages": "*"
  };

  // Prepare Request Options
  var options = {
    'method': 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": pdfCoAPIKey
    },
	
	// Convert the JavaScript object to a JSON string
    'payload': JSON.stringify(data)
  };

  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/split', options);

  var pdfCoRespContent = pdfCoResponse.getContentText();
  var pdfCoRespJson = JSON.parse(pdfCoRespContent);

  var resultUrls = pdfCoRespJson.urls;
  
  // Save Split PDFs in Google Drive Folder
  for(let i=0;i<resultUrls.length;i++) {
    var splitFile = UrlFetchApp.fetch(resultUrls[i]).getBlob();

    DriveApp.getFolderById(googleDriveFolderId).createFile(splitFile);
  }
}