/* Initial Declarations */
let Cell_PDFcoApiKey, PDFCoApiKey, Cell_InputPDFUrl, InputPDFUrl, Cell_CompanyName, Cell_BillTo, Cell_InvoiceNo, Cell_InvoiceDate, Cell_DueDate, Cell_SubTotal, Cell_Tax, Cell_TotalAmount, Cell_Error;


/*
 * Handle PDF.co Menu on Google Sheet Open Event
 */
function onOpen() {
  var spreadsheet = SpreadsheetApp.getActive();
  var menuItems = [
    { name: 'Read Invoice Data', functionName: 'ParseInvoiceData' }
  ];
  spreadsheet.addMenu('PDF.co', menuItems);
}


/**
 * Parse Invoice Data and put it into a spreadsheet
 */
function ParseInvoiceData() {
  // Initial Cell reference and clean
  AssignInitialCellRefAndClean();


  if (!ValidateInputValues()) {
    return;
  }


  // Prepare Payload
  var data = {
    "url": InputPDFUrl,
    "outputFormat": "JSON",
    "templateId": "1",
    "async": true, // Use async for job handling
    "encrypt": "false",
    "inline": "true",
  };


  // Prepare Request Options
  var options = {
    'method': 'post',
    'contentType': 'application/json',
    'headers': {
      "x-api-key": PDFCoApiKey
    },
    'payload': JSON.stringify(data)
  };


  // Send Request to PDF.co
  var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/documentparser', options);
  var pdfCoRespJson = JSON.parse(pdfCoResponse.getContentText());


  // Check if the API returned an error
  if (pdfCoRespJson.error) {
    Cell_Error.setValue(pdfCoRespJson.message);
    return;
  }


  // Get Job ID for async processing
  var jobId = pdfCoRespJson.jobId;
  Logger.log(`Job started: ${jobId}`);


  // Wait for the job to complete
  var result = checkIfJobIsCompleted(PDFCoApiKey, jobId);


  if (result) {
    Cell_CompanyName.setValue(ExtractFieldFromResponse(result, "companyName"));
    Cell_BillTo.setValue(ExtractFieldFromResponse(result, "companyName2"));
    Cell_InvoiceNo.setValue(ExtractFieldFromResponse(result, "invoiceId"));
    Cell_InvoiceDate.setValue(ExtractFieldFromResponse(result, "dateIssued"));
    Cell_DueDate.setValue(ExtractFieldFromResponse(result, "dateDue"));
    Cell_SubTotal.setValue(ExtractFieldFromResponse(result, "subTotal"));
    Cell_Tax.setValue(ExtractFieldFromResponse(result, "tax"));
    Cell_TotalAmount.setValue(ExtractFieldFromResponse(result, "total"));
  } else {
    Cell_Error.setValue("The job failed or timed out.");
  }
}


/**
 * Check if an async job is completed
 */
function checkIfJobIsCompleted(apiKey, jobId) {
  var queryPath = 'https://api.pdf.co/v1/job/check';
  var maxRetries = 20; // Maximum retries to check job status
  var retries = 0;


  while (retries < maxRetries) {
    var data = { "jobid": jobId };
    var options = {
      'method': 'post',
      'contentType': 'application/json',
      'headers': {
        "x-api-key": apiKey
      },
      'payload': JSON.stringify(data)
    };


    var response = UrlFetchApp.fetch(queryPath, options);
    var jsonResponse = JSON.parse(response.getContentText());


    Logger.log(`Job status: ${jsonResponse.status}`);


    if (jsonResponse.status === "working") {
      Utilities.sleep(5000); // Wait for 5 seconds before checking again
      retries++;
    } else if (jsonResponse.status === "success") {
      return jsonResponse; // Return the successful response
    } else {
      Logger.log(`Job failed: ${JSON.stringify(jsonResponse)}`);
      return null; // Job failed or encountered an error
    }
  }


  Logger.log("Job exceeded retry limit.");
  return null; // Job did not complete in time
}


/**
 * Validate Input Values before request
 */
function ValidateInputValues() {
  if (InputPDFUrl === "") {
    Cell_Error.setValue("Please Provide Input Invoice PDF URL");
    return false;
  }


  if (PDFCoApiKey === "") {
    Cell_Error.setValue("Please Provide PDF.co API Key");
    return false;
  }


  Cell_Error.setValue("");
  return true;
}


/**
 * Extract field value from JSON response
 */
function ExtractFieldFromResponse(respJson, fieldName) {
  let retVal = "";


  if (respJson && respJson.body && respJson.body.objects && respJson.body.objects.length > 0) {
    const objectField = respJson.body.objects.filter(x => x.name === fieldName && x.objectType === "field");
    if (objectField && objectField.length > 0) {
      retVal = objectField[0].value;
    }
  }


  return retVal;
}


/**
 * Assign Initial References
 */
function AssignInitialCellRefAndClean() {
  var spreadsheet = SpreadsheetApp.getActive();


  // Assign Cell References
  Cell_PDFcoApiKey = spreadsheet.getRange("B1");
  PDFCoApiKey = Cell_PDFcoApiKey.getValue();


  Cell_InputPDFUrl = spreadsheet.getRange("B2");
  InputPDFUrl = Cell_InputPDFUrl.getValue();


  Cell_CompanyName = spreadsheet.getRange("A5");
  Cell_BillTo = spreadsheet.getRange("B5");
  Cell_InvoiceNo = spreadsheet.getRange("C5");
  Cell_InvoiceDate = spreadsheet.getRange("D5");
  Cell_DueDate = spreadsheet.getRange("E5");
  Cell_SubTotal = spreadsheet.getRange("F5");
  Cell_Tax = spreadsheet.getRange("G5");
  Cell_TotalAmount = spreadsheet.getRange("H5");
  Cell_Error = spreadsheet.getRange("A3:H3");


  Cell_CompanyName.setValue("");
  Cell_BillTo.setValue("");
  Cell_InvoiceNo.setValue("");
  Cell_InvoiceDate.setValue("");
  Cell_DueDate.setValue("");
  Cell_SubTotal.setValue("");
  Cell_Tax.setValue("");
  Cell_TotalAmount.setValue("");
  Cell_Error.setValue("");
}



