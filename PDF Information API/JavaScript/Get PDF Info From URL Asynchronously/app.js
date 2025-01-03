//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//


const axios = require("axios");


const API_KEY = "***********";


// Direct URL of source PDF file.
const SourceFileUrl = "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf";


// Prepare the API request URL
const apiUrl = "https://api.pdf.co/v1/pdf/info";


// JSON payload for API request
const jsonPayload = {
  url: SourceFileUrl,
  async: true,  // Enable asynchronous processing
};


// Send request using axios
axios.post(apiUrl, jsonPayload, {
  headers: {
    "x-api-key": API_KEY,
    "Content-Type": "application/json",
  },
})
  .then((response) => {
    const data = response.data;
    if (data.error === false) {
      // Print job ID for async processing
      console.log("Job ID:", data.jobId);
      
      // Now, check the status of the asynchronous job
      checkAsyncJobStatus(data.jobId);
    } else {
      // Handle API error
      console.log("Error:", data.message);
    }
  })
  .catch((error) => {
    // Handle request error
    console.error("Request Error:", error);
  });


// Function to check the status of the asynchronous job
function checkAsyncJobStatus(jobId) {
  const statusUrl = "https://api.pdf.co/v1/job/check";


  // Send request to check job status using axios
  axios.post(statusUrl, 
    new URLSearchParams({
      jobid: jobId
    }), {
      headers: {
        "x-api-key": API_KEY,
      },
    })
    .then((response) => {
      console.log("Job Check Response:", response.data);
      
      // Handle status response accordingly
      const statusData = response.data;
      if (statusData.status === "success") {
        console.log("PDF extraction completed:", statusData);
      } else if (statusData.status === "failed") {
        console.log("PDF extraction failed.");
      } else {
        console.log("PDF extraction is still processing...");
      }
    })
    .catch((error) => {
      console.error("Status Request Error:", error);
    });
}
