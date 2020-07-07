## How to merge PDF documents (jquery) for PDF merging API in JavaScript with PDF.co Web API

### Learn how to merge PDF documents (jquery) to have PDF merging API in JavaScript

These source code samples are listed and grouped by their programming language and functions they use. PDF.co Web API was made to help with PDF merging API in JavaScript. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

Fast application programming interfaces of PDF.co Web API for JavaScript plus the instruction and the code below will help to learn how to merge PDF documents (jquery). Sample code in JavaScript is all you need. Copy-paste it to your the code editor, then add a reference to PDF.co Web API and you are ready to try it! Further enhancement of the code will make it more vigorous.

ByteScout free trial version is available for FREE download from our website. Programming tutorials along with source code samples are included.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore Documentation](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Explore Source Code Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://app.pdf.co/signup?utm_source=github-readme)
[Security](https://pdf.co/security)
[Explore Web API Documentation](https://apidocs.pdf.co?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### **merge.js:**
    
```
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

    var apiKey = $("#apiKey").val().trim(); //Get your API key at https://app.pdf.co/documentation/api

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
```

<!-- code block end -->