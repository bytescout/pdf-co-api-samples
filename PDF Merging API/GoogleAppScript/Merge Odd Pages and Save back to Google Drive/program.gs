function getPageCount() {
  var apiKey = '******************';
  var sourcePdfUrl = 'https://drive.google.com/file/d/1vpZkhgVd_ZEKHRKKUAP4zeNYPjviiYym/view?usp=sharing';

  // Call the PDF Info API to get the page count
  var response = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/info', {
    'method': 'POST', // Use POST request
    'headers': {
      'x-api-key': apiKey,
      'Content-Type': 'application/json'
    },
    'payload': JSON.stringify({ url: sourcePdfUrl }) // Send the URL as JSON payload
  });

  var json = JSON.parse(response.getContentText());
  var pageCount = json.info.PageCount;

  // Step 2: Split the PDF to extract odd pages
  var oddPages = "";
  for (var i = 1; i <= pageCount; i += 2) {
    if (oddPages !== "") oddPages += ",";
    oddPages += i;
  }

  var splitResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/split?name=odd_pages.pdf', {
    'method': 'POST', // Use POST request
    'headers': {
      'x-api-key': apiKey,
      'Content-Type': 'application/json'
    },
    'payload': JSON.stringify({ url: sourcePdfUrl, pages: oddPages }) // Send the URL and pages as JSON payload
  });

  var splitJson = JSON.parse(splitResponse.getContentText());
  var oddPagesFileUrls = splitJson.urls;
  
  // Remove square brackets and join the URLs with a comma
  var oddPagesUrls = oddPagesFileUrls.join(',');

  // Step 3: Merge the odd pages into a new PDF
  var mergeResponse = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/merge?name=merged.pdf', {
    'method': 'POST', // Use POST request
    'headers': {
      'x-api-key': apiKey,
      'Content-Type': 'application/json'
    },
    'payload': JSON.stringify({ url: oddPagesUrls }) // Send the oddPagesFileUrl as JSON payload
  });

  var mergeJson = JSON.parse(mergeResponse.getContentText());
  var mergedPdfUrl = mergeJson.url;
  Logger.log(mergedPdfUrl);

  // Optional: Save the merged PDF to Google Drive
  var response = UrlFetchApp.fetch(mergedPdfUrl);
  var pdfBlob = response.getBlob();
  DriveApp.createFile(pdfBlob).setName('Merged PDF with Odd Pages.pdf');
}
