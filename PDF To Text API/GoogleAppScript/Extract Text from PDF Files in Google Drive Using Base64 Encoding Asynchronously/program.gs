const PDFCO_API_KEY = 'YOUR_PDFCO_API_KEY';
const SOURCE_FOLDER_ID = 'YOUR_SOURCE_FOLDER_ID';
const DESTINATION_FOLDER_ID = 'YOUR_DESTINATION_FOLDER_ID';

function processPDFsInFolder() {
  const sourceFolder = DriveApp.getFolderById(SOURCE_FOLDER_ID);
  const destinationFolder = DriveApp.getFolderById(DESTINATION_FOLDER_ID);
  const files = sourceFolder.getFilesByType(MimeType.PDF);

  if (!files.hasNext()) {
    Logger.log("No PDF files found in the source folder.");
    return;
  }

  while (files.hasNext()) {
    const file = files.next();
    const fileName = file.getName();
    Logger.log(`Processing file: ${fileName}`);

    try {
      // Step 1: Convert to Base64 and upload to PDF.co
      const uploadResult = uploadBase64ToPDFco(Utilities.base64Encode(file.getBlob().getBytes()), fileName);
      if (!uploadResult || !uploadResult.url) throw new Error(`Failed to upload ${fileName}`);

      // Step 2: Extract text from the uploaded file asynchronously
      const extractedText = extractTextFromPDF(uploadResult.url);
      if (!extractedText) throw new Error(`Failed to extract text from ${fileName}`);

      // Step 3: Save the extracted text as a .txt file
      destinationFolder.createFile(Utilities.newBlob(extractedText, 'text/plain', fileName.replace('.pdf', '.txt')));
      Logger.log(`Successfully processed and saved text for: ${fileName}`);
    } catch (error) {
      Logger.log(`Error processing file (${fileName}): ${error.message}`);
    }
  }

  Logger.log("Processing complete for all files.");
}

function uploadBase64ToPDFco(base64Content, fileName) {
  try {
    const response = UrlFetchApp.fetch('https://api.pdf.co/v1/file/upload/base64', {
      method: 'post',
      contentType: 'application/json',
      headers: { 'x-api-key': PDFCO_API_KEY },
      payload: JSON.stringify({ name: fileName, file: base64Content })
    });
    const jsonResponse = JSON.parse(response.getContentText());
    if (jsonResponse.error) throw new Error(jsonResponse.message);
    return jsonResponse;
  } catch (error) {
    Logger.log(`Upload failed for ${fileName}: ${error.message}`);
    return null;
  }
}

function extractTextFromPDF(fileUrl) {
  try {
    // Send an asynchronous request with the "profiles" parameter
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

    if (jobStatus === 'failed') throw new Error(`Job failed for URL: ${fileUrl}`);

    // Fetch the result from the job's result URL
    return UrlFetchApp.fetch(jsonResponse.url).getContentText();
  } catch (error) {
    Logger.log(`Text extraction failed for URL ${fileUrl}: ${error.message}`);
    return null;
  }
}