const PDFCO_API_KEY = 'YOUR_API_KEY'; // Replace with your PDF.co API key

function processPDFsAndExtractText() {
  const sheetName = 'Emails';
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(sheetName);

  if (!sheet) {
    Logger.log(`Sheet "${sheetName}" not found.`);
    return;
  }

  const data = sheet.getDataRange().getValues(); // Get all rows
  for (let i = 1; i < data.length; i++) { // Skip header row
    const folderLink = data[i][5]; // Folder link in column F

    if (!folderLink || !folderLink.includes('/folders/')) {
      Logger.log(`Invalid folder link in row ${i + 1}. Skipping.`);
      continue;
    }

    const folderId = folderLink.split('/folders/')[1];
    Logger.log(`Processing folder: ${folderId}`);

    try {
      const folder = DriveApp.getFolderById(folderId);
      const files = folder.getFilesByType(MimeType.PDF);

      while (files.hasNext()) {
        const file = files.next();
        const fileName = file.getName();

        // Skip already logged files
        if (isFileAlreadyLogged(sheet, fileName)) {
          Logger.log(`File ${fileName} already processed. Skipping.`);
          continue;
        }

        Logger.log(`Processing file: ${fileName}`);

        try {
          const pdfBase64 = Utilities.base64Encode(file.getBlob().getBytes());
          const uploadResult = uploadBase64ToPDFco(pdfBase64, fileName);

          if (!uploadResult || !uploadResult.url) throw new Error('File upload failed');

          const extractedText = extractTextFromPDFAsync(uploadResult.url);
          if (!extractedText) throw new Error('Text extraction failed');

          const month = extractMonthFromText(extractedText) || 'NoMonth';
          const accountNumber = extractAccountNumber(extractedText);

          if (!accountNumber) {
            Logger.log(`No account number found in text for file: ${fileName}. Skipping renaming.`);
            continue;
          }

          const fullAccountNumber = accountNumber.full; // Full account number
          const last4Digits = accountNumber.last4; // Last 4 digits for renaming

          // Rename file and log updates
          const newFileName = `${month}_${last4Digits}.pdf`;
          file.setName(newFileName);
          Logger.log(`Renamed to: ${newFileName}`);

          // Log results in the sheet
          sheet.appendRow([
            new Date(), // Date processed
            null,       // Thread ID
            null,       // Message ID
            newFileName,
            null,       // Email From
            folderLink,
            extractedText,
            month,
            fullAccountNumber // Log the full account number
          ]);

          Logger.log(`Processed and logged: ${newFileName}`);
        } catch (error) {
          Logger.log(`Error processing file (${fileName}): ${error.message}`);
        }
      }
      sheet.getRange(i + 1, 7).setValue('Processed'); // Update column G
    } catch (error) {
      Logger.log(`Error processing folder ${folderId}: ${error.message}`);
      sheet.getRange(i + 1, 7).setValue(`Error: ${error.message}`); // Update column G
    }
  }
  Logger.log('Processing complete.');
}

function isFileAlreadyLogged(sheet, fileName) {
  const loggedFiles = sheet.getRange(2, 4, sheet.getLastRow() - 1).getValues().flat(); // Column D
  return loggedFiles.includes(fileName);
}

function uploadBase64ToPDFco(base64Content, fileName) {
  try {
    const response = UrlFetchApp.fetch('https://api.pdf.co/v1/file/upload/base64', {
      method: 'post',
      contentType: 'application/json',
      headers: { 'x-api-key': PDFCO_API_KEY },
      payload: JSON.stringify({ name: fileName, file: base64Content })
    });
    const result = JSON.parse(response.getContentText());
    if (result.error) throw new Error(result.message);
    return result;
  } catch (error) {
    Logger.log(`Upload failed: ${error.message}`);
    return null;
  }
}

function extractTextFromPDFAsync(fileUrl) {
  try {
    // Start the asynchronous text extraction process
    const response = UrlFetchApp.fetch('https://api.pdf.co/v1/pdf/convert/to/text', {
      method: 'post',
      contentType: 'application/json',
      headers: { 'x-api-key': PDFCO_API_KEY },
      payload: JSON.stringify({
        async: true,
        url: fileUrl,
        lang: 'eng',
        profiles: "{'OCRMode':'Auto'}"
      })
    });
    const jsonResponse = JSON.parse(response.getContentText());
    if (jsonResponse.error) throw new Error(jsonResponse.message);

    const jobId = jsonResponse.jobId;
    Logger.log(`Job created with ID: ${jobId}`);

    // Poll the job/check endpoint until the job is completed
    let jobStatus = null;
    do {
      Utilities.sleep(5000); // Wait for 5 seconds before checking the status
      const statusResponse = UrlFetchApp.fetch(`https://api.pdf.co/v1/job/check?jobid=${jobId}`, {
        method: 'get',
        headers: { 'x-api-key': PDFCO_API_KEY }
      });
      const statusJson = JSON.parse(statusResponse.getContentText());
      if (statusJson.error) throw new Error(statusJson.message);

      jobStatus = statusJson.status;
      Logger.log(`Job status: ${jobStatus}`);
    } while (jobStatus !== 'success' && jobStatus !== 'failed');

    if (jobStatus === 'failed') throw new Error('Job failed during text extraction');

    // Fetch the extracted text
    return UrlFetchApp.fetch(jsonResponse.url).getContentText();
  } catch (error) {
    Logger.log(`Text extraction failed: ${error.message}`);
    return null;
  }
}

function extractMonthFromText(text) {
  const match = text.match(/(January|February|March|April|May|June|July|August|September|October|November|December)/i);
  return match ? match[0] : null;
}

function extractAccountNumber(text) {
  const normalizedText = text.replace(/\s+/g, ' ').trim();
  Logger.log(`Normalized text: ${normalizedText}`);
  
  const accountNumberRegex = /Account Number:\s*(\d+)/i;
  const match = normalizedText.match(accountNumberRegex);
  
  if (match) {
    const fullAccountNumber = match[1]; // Extract the full account number
    const last4Digits = fullAccountNumber.slice(-4); // Get the last 4 digits
    Logger.log(`Full Account Number: ${fullAccountNumber}, Last 4 Digits: ${last4Digits}`);
    return { full: fullAccountNumber, last4: last4Digits };
  } else {
    Logger.log(`No account number found in text.`);
    return null;
  }
}
