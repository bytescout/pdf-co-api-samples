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


// Requiring modules
const express = require('express');
const axios = require('axios');


// Creating express object
const app = express();


const options = {
    method: 'POST',
    url: 'https://api.pdf.co/v1/pdf/edit/delete-pages',
    headers: {
        'x-api-key': '*******************************************************',
        'Content-Type': 'application/json',
    },
    data: {
        url: 'https://juventudedesporto.cplp.org/files/sample-pdf_9359.pdf',
        pages: '1-3',
        name: 'result.pdf',
        async: true // Enable asynchronous processing
    }
};


// Sending the request
axios(options)
    .then((response) => {
        console.log(response.data); 
        // In async mode, check for job ID and status URL in the response
    })
    .catch((error) => {
        console.error(error);
    });
