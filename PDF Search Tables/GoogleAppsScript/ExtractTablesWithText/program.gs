/**
 * Initial Declaration and References
 */

// Get UI
const ui = SpreadsheetApp.getUi();

// Get the active spreadsheet and the active sheet
const ss = SpreadsheetApp.getActiveSpreadsheet();
const ssid = ss.getId();
let rowIndex = 1; // Used to write into excel


// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co
const PDFcoAPIKEY = 'YOUR_API_KEY_HERE';

// Direct URL of source PDF file.
// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
const SourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf";

// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
const Pages = "";

// PDF document password. Leave empty for unprotected documents.
const Password = "";


function findTablesInPDF() {
  // Prepare Payload
  var data = {
    "url": SourceFileUrl,
    "pages": Pages,
    "password": Password,
    "profiles": "{ 'Mode': 'Legacy', 'ColumnDetectionMode': 'BorderedTables', 'DetectionMinNumberOfRows': 1, 'DetectionMinNumberOfColumns': 1, 'DetectionMaxNumberOfInvalidSubsequentRowsAllowed': 0, 'DetectionMinNumberOfLineBreaksBetweenTables': 0, 'EnhanceTableBorders': false }"
  };

  // Prepare Request Options
  var options = {
    'method': 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": PDFcoAPIKEY
    },
    // Convert the JavaScript object to a JSON string.
    'payload': JSON.stringify(data)
  };

  // Get Response
  // https://developers.google.com/apps-script/reference/url-fetch
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/find/table', options);

  var pdfCoRespText = pdfCoResponse.getContentText();
  var jsonBody = JSON.parse(pdfCoRespText);

  // Loop through all found tables, and get json data
  if (jsonBody.body.tables && jsonBody.body.tables.length > 0) {
    for (let i = 0; i < jsonBody.body.tables.length; i++) {
      const returnedTableJson = getJSONFromCoordinates(SourceFileUrl, jsonBody.body.tables[i].PageIndex, jsonBody.body.tables[i].rect);

      if(returnedTableJson && returnedTableJson.body && returnedTableJson.body.document && returnedTableJson.body.document.page && returnedTableJson.body.document.page.row && returnedTableJson.body.document.page.row.length > 0){
        for(let index = 0; index < returnedTableJson.body.document.page.row.length; index++, rowIndex++){
          const curRow = returnedTableJson.body.document.page.row[index];
          if(curRow.column && curRow.column.length > 0){
            for(let indexColumn = 0; indexColumn < curRow.column.length; indexColumn++){
              const curCol = curRow.column[indexColumn];
              if(typeof curCol == "object"){
                ss.getRange(`${String.fromCharCode(65 + indexColumn)}${rowIndex}`).setValue(curCol.text.text);
              }
            }
          }
        }
      }
    }
  } 
}

/**
 * Get JSON from specific co-ordinates
 */
function getJSONFromCoordinates(fileUrl, pageIndex, rect) {
  // Prepare Payload
  var data = {
    "url": fileUrl,
    "pages": pageIndex.toString(),
    "rect": rect,
    inline: true
  };

  // Prepare Request Options
  var options = {
    'method': 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": PDFcoAPIKEY
    },
    // Convert the JavaScript object to a JSON string.
    'payload': JSON.stringify(data)
  };

  // Get Response
  // https://developers.google.com/apps-script/reference/url-fetch
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/convert/to/json2', options);

  var pdfCoRespText = pdfCoResponse.getContentText();
  return JSON.parse(pdfCoRespText);
}
