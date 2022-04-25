/**
 * Initial Declaration and References
 */

// Get the active spreadsheet and the active sheet
const ss = SpreadsheetApp.getActiveSpreadsheet();

// PDF.co API Key
const API_Key = "_YOUR_PDFco_API_Key_HERE_";

/**
 * Add PDF.co Menus in Google Spreadsheet
 */
function onOpen() {
    var menuItems = [
        { name: 'Get PDF Invoice', functionName: 'getPDFInvoice' }
    ];
    ss.addMenu('PDF.co', menuItems);
}


/**
 * Function which gets Invoice Information using PDF.co
 */
function getPDFInvoice() {

    let invoiceData = JSON.stringify(generateInvoiceJson());

    // Prepare Payload
    var data = {
        "templateId": 3,
        "templateData": invoiceData
    };

    // Prepare Request Options
    var options = {
        'method': 'post',
        'contentType': 'application/json',
        'headers': {
            "x-api-key": API_Key
        },
        // Convert the JavaScript object to a JSON string.
        'payload': JSON.stringify(data)
    };

    // Get Response
    // https://developers.google.com/apps-script/reference/url-fetch
    var pdfCoResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/convert/from/html', options);

    var pdfCoRespText = pdfCoResponse.getContentText();
    var pdfCoRespJson = JSON.parse(pdfCoRespText);

    let resultUrlCell = ss.getRange(`H1`);

    // Display Result
    if (!pdfCoRespJson.error) {
        resultUrlCell.setValue(pdfCoRespJson.url);
    }
    else {
        resultUrlCell.setValue(pdfCoRespJson.message);
    }
}

/**
 * Function to Generate Invoice JSON
 */
function generateInvoiceJson() {
    let oRet = {};

    oRet.paid = ss.getRange(`F1`).getValue();
    oRet.company_name = ss.getRange(`B1`).getValue();
    oRet.company_address = ss.getRange(`D1`).getValue();
    oRet.company_logo = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png";
    oRet.barcode_value = ss.getRange(`B2`).getValue();
    oRet.ocr_scanline = ss.getRange(`B2`).getValue();
    oRet.order_id = ss.getRange(`B2`).getValue();
    oRet.order_date = ss.getRange(`D2`).getValue();
    oRet.customer_id = ss.getRange(`F2`).getValue();
    oRet.shipped_date = ss.getRange(`F3`).getValue();
    oRet.shipped_via = ss.getRange(`F4`).getValue();
    oRet.bill_to_name = ss.getRange(`B3`).getValue();
    oRet.bill_to_address = ss.getRange(`D3`).getValue();
    oRet.ship_to_name = ss.getRange(`B4`).getValue();
    oRet.ship_to_address = ss.getRange(`D4`).getValue();
    oRet.freight = ss.getRange(`B5`).getValue();
    oRet.notes = ss.getRange(`D5`).getValue();

    oRet.items = getInvoiceItemsJson();

    return oRet;
}

function getInvoiceItemsJson() {
    var oRet = [];

    let index = 9;
    let isDataAvailable = ss.getRange(`A${index}:B${index}`).getValue() !== "";

    while (isDataAvailable) {
        oRet.push({
            "name": ss.getRange(`A${index}:B${index}`).getValue(),
            "price": ss.getRange(`C${index}`).getValue(),
            "quantity": ss.getRange(`D${index}`).getValue()
        });

        index++;
        isDataAvailable = ss.getRange(`A${index}:B${index}`).getValue() !== "";
    }

    return oRet;
}
