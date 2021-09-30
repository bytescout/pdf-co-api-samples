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


$(document).ready(function () {
    $("#resultBlock").hide();
    $("#errorBlock").hide();
    $("#result").attr("href", '').html('');
});

$(document).on("click", "#submit", function () {
    $("#resultBlock").hide();
    $("#errorBlock").hide();
    $("#inlineOutput").text(''); // inline output div
    $("#status").text(''); // status div

    var apiKey = $("#apiKey").val().trim(); //Get your API key at https://app.pdf.co

    var formData = new FormData();
    formData.append('name', 'result.pdf');
    
    // Append files in input request
    formData.append('file[]', $("#form input[type=file]")[0].files[0]);
    formData.append('file[]', $("#form input[type=file]")[1].files[0]);

    $("#status").html('Processing... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

    $.ajax({
        url: 'https://api.pdf.co/v1/pdf/merge',
        type: 'POST',
        headers: { 'x-api-key': apiKey },
        data: formData,
        contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
        processData: false, // NEEDED, DON'T OMIT THIS
        success: function (result) {
            $("#status").text('Success!');

            $("#resultBlock").show();
            $("#inlineOutput").html('<iframe style="width:100%; height:500px;" src="'+ result.url +'" />');
        },
        error: function () {
            $("#status").text('error');
        }
    });
 });
