//*******************************************************************************************//
//                                                                                           //
// Get Your API Key: https://app.pdf.co/signup                                               //
// API Documentation: https://developer.pdf.co/api/index.html                                //
//                                                                                           //
// Note: Replace placeholder values in the code with your API Key                            //
// and file paths (if applicable)                                                            //
//                                                                                           //
//*******************************************************************************************//


// Visit Knowledgebase for adding Text Macros to PDF 
// https://apidocs.pdf.co/kb/Fill%20PDF%20and%20Add%20Text%20or%20Images%20(pdf-edit-add)/macros

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

    var inputText = $("#inputText").val();
    var fontName = $("#fontName").val();
    var fontSize = $("#fontSize").val();
    var fontColor = $("#fontColor").val();

    var destinationXCoordinate = $("#destinationXCoordinate").val();
    var destinationYCoordinate = $("#destinationYCoordinate").val();

    var formData = $("#SourceFile")[0].files[0]; // file to upload

    $("#status").html('Getting presigned url... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

    $.ajax({
        url: 'https://api.pdf.co/v1/file/upload/get-presigned-url?name=test.pdf&contenttype=application/pdf&encrypt=true',
        type: 'GET',
        headers: { 'x-api-key': apiKey }, // passing our api key
        success: function (result) {

            if (result['error'] === false) {
                console.log(result);
                var presignedUrl = result['presignedUrl']; // reading provided presigned url to put our content into
                var uploadedUrl = result['url']; // Uploaded URL

                $("#status").html('Uploading... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');

                $.ajax({
                    url: presignedUrl, // no api key is required to upload file
                    type: 'PUT',
                    headers: { 'content-type': 'application/pdf' }, // setting to pdf type as we are uploading pdf file
                    data: formData,
                    processData: false,
                    success: function (result) {

                        // Request Url
                        var cUrl = 'https://api.pdf.co/v1/pdf/edit/add';

                        // Input Data
                        var data = {
                            name: 'result.pdf',
                            url: uploadedUrl,
                            annotations: [{
                                x: destinationXCoordinate,
                                y: destinationYCoordinate,
                                text: inputText,
                                fontname: fontName,
                                size: fontSize,
                                color: fontColor
                            }]
                        };

                        $("#status").html('Processing... &nbsp;&nbsp;&nbsp; <img src="ajax-loader.gif" />');
                        $.ajax({
                            url: cUrl,
                            type: 'POST',
                            headers: { 'x-api-key': apiKey, 'Content-Type': 'application/json'  },
                            processData: false,
                            contentType: false,
                            data: JSON.stringify(data),
                            success: function (result) {
                                $("#status").text('done processing.');

                                if (result.error) {
                                    $("#errorBlock").show();
                                    $("#errors").text(result.message);
                                } else {
                                    $("#resultBlock").show();
                                    $("#inlineOutput").text(JSON.stringify(result));
                                    $("#iframeResultPdf").prop("src", result.url);
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

