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


var apiKey, formData, toType, isInline;

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
 
    apiKey = $("#apiKey").val().trim(); //Get your API key at https://app.pdf.co/documentation/api
 
    formData = $("#form input[type=file]")[0].files[0]; // file to upload
    toType = $("#convertType").val(); // output type
    isInline = $("#outputType").val() == "inline"; // if we need output as inline content or link to output file

    $("#status").html('Requesting presigned url for upload... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

    $.ajax({
        url: 'https://api.pdf.co/v1/file/upload/get-presigned-url?name=test.pdf&contenttype=application/pdf&encrypt=true',
        type: 'GET',
        headers: {'x-api-key': apiKey}, // passing our api key
        success: function (result) {    

            if (result['error'] === false) {
                var presignedUrl = result['presignedUrl']; // reading provided presigned url to put our content into
                var accessUrl = result['url']; // reading output url that will indicate uploaded file

                $("#status").html('Uploading... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

                $.ajax({
                    url: presignedUrl, // no api key is required to upload file
                    type: 'PUT',
                    headers: {'content-type': 'application/pdf'}, // setting to pdf type as we are uploading pdf file
                    data: formData,
                    processData: false,
                    success: function (result) {                               
                        
                        $("#status").html('Processing... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

                        $.ajax({
                            url: 'https://api.pdf.co/v1/pdf/convert/to/'+toType+'?url='+ presignedUrl + '&encrypt=true&inline=' + isInline + '&async=True',
                            type: 'POST',
                            headers: {'x-api-key': apiKey},
                            success: function (result) { 
                                if (result.error) {
                                    $("#status").text('Error uploading file.');
                                }
                                else {
                                    checkIfJobIsCompleted(result.jobId, result.url);
                                }
                            }
                        });
                    },
                    error: function () {
                        $("#status").text('error');
                    }
                  });                
        

                }
            }
        });
});
 
function checkIfJobIsCompleted(jobId, resultFileUrl) {
    $.ajax({
        url: 'https://api.pdf.co/v1/job/check?jobid=' + jobId,
        type: 'GET',
        headers: { 'x-api-key': apiKey }, // passing our api key
        success: function (jobResult) {

            $("#status").html(jobResult.status + ' &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

            if (jobResult.status == "working") {
                // Check again after 3 seconds
                setTimeout(function(){
                    checkIfJobIsCompleted(jobId, resultFileUrl);
                }, 3000);
            }
            else if (jobResult.status == "success") {

                $("#status").text('Done converting.');

                $("#resultBlock").show();

                if (isInline && toType != "xls" && toType != "xlsx") {
                    $.ajax({
                        url: resultFileUrl,
                        dataType: 'text',
                        success: function(respText){
                            $("#inlineOutput").text(respText);
                        }
                    });
                }
                else {
                    $("#result").attr("href", resultFileUrl).html(resultFileUrl);
                }
            }
        }
    });
}
