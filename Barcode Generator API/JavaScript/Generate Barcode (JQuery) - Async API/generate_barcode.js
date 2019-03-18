//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Free Trial Sign Up: https://secure.bytescout.com/users/sign_up //
//                                                                                           //
// Copyright © 2017-2018 ByteScout Inc. All rights reserved.                                 //
// http://www.bytescout.com                                                                  //
//                                                                                           //
//*******************************************************************************************//


var apiKey = "";

$(document).ready(function () {
    $("#resultBlock").hide();
    $("#errorBlock").hide();
});

$(document).on("click", "#submit", function () {
    apiKey = $("#apiKey").val().trim(); //Get your API key by registering at https://app.pdf.co/documentation/api

    var url = "https://api.pdf.co/v1/barcode/generate?name=barcode.png";
    url += "&type=" + $("#barcodeType").val(); // Set barcode type (symbology)
    url += "&value=" + $("#inputValue").val(); // Set barcode value
    url += "&async=True"; // Set async

    // Show loader
    $("#loader").show();

    $.ajax({
        url: url,
        type: "GET",
        headers: {
            "x-api-key": apiKey
        },
    })
        .done(function (data, textStatus, jqXHR) {

            if (data.error) {
                $("#errorBlock").show();
                $("#error").html(data.message);
                $("#loader").hide();
            }
            else {
                checkIfJobIsCompleted(data.jobId, data.url);
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            $("#errorBlock").show();
            $("#error").html("Request failed. Please check you use the correct API key.");
            $("#loader").hide();
        });
});

function checkIfJobIsCompleted(jobId, resultFileUrl) {
    $.ajax({
        url: 'https://api.pdf.co/v1/job/check?jobid=' + jobId,
        type: 'GET',
        headers: { 'x-api-key': apiKey }, // passing our api key
        success: function (jobResult) {

            $("#status").html(jobResult.Status + ' &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

            if (jobResult.Status == "InProgress") {
                // Check again after 3 seconds
                setTimeout(function(){
                    checkIfJobIsCompleted(jobId, resultFileUrl);
                }, 3000);
            }
            else if (jobResult.Status == "Finished") {
                $("#resultBlock").show();
                $("#image").attr("src", resultFileUrl);
            }

            $("#loader").hide();
        },
        error: function(){
            $("#errorBlock").show();
            $("#error").html("Request failed. Please check you use the correct API key.");
            $("#loader").hide();
        }
    });
}
