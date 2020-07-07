## How to convert PDF to HTML asynchronously for PDF to HTML API in PHP with PDF.co Web API

### See how to convert PDF to HTML asynchronously to have PDF to HTML API in PHP

Here you may find thousands pre-made source code pieces for easy implementation in your own programming projects. PDF.co Web API was made to help with PDF to HTML API in PHP. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

PHP code snippet like this for PDF.co Web API works best when you need to quickly implement PDF to HTML API in your PHP application. For implimentation of this functionality, please copy and paste code below into your app using code editor. Then compile and run your app. Enjoy writing a code with ready-to-use sample PHP codes to implement PDF to HTML API using PDF.co Web API.

Our website provides free trial version of PDF.co Web API that includes source code samples to help with your PHP project.

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

##### **pdf-to-html-async.php:**
    
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cloud API asynchronous "PDF To HTML" job example (allows to avoid timeout errors).</title>
</head>
<body>

<?php 

// Cloud API asynchronous "PDF To HTML" job example.
// Allows to avoid timeout errors when processing huge or scanned PDF documents.


// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co/documentation/api
$apiKey = "***********************************";

// Direct URL of source PDF file. Check another example if you need to upload a local file to the cloud.
$sourceFileUrl = "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/long-processed-document.pdf";
// Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$pages = "";
// PDF document password. Leave empty for unprotected documents.
$password = "";
// Set to `true` to get simplified HTML without CSS. Default is the rich HTML keeping the document design.
$plainHtml = false;
// Set to `true` if your document has the column layout like a newspaper.
$columnLayout = false;


// Prepare URL for `PDF To XLSX` API call
$url = "https://api.pdf.co/v1/pdf/convert/to/html" .
    "?url=" . $sourceFileUrl .
    "&password=" . $password .
    "&pages=" . $pages .
    "&simple=" . $plainHtml .
    "&columns=" . $columnLayout .
    "&async=true"; // (!) Make asynchronous job

// Create request
$curl = curl_init();
curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey));
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

// Execute request
$result = curl_exec($curl);

if (curl_errno($curl) == 0)
{
    $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    
    if ($status_code == 200)
    {
        $json = json_decode($result, true);
        
        if ($json["error"] == false)
        {
            // URL of generated HTML file that will available after the job completion
            $resultFileUrl = $json["url"];
            // Asynchronous job ID
            $jobId = $json["jobId"];
            
            // Check the job status in a loop
            do
            {
                $status = CheckJobStatus($jobId); // Possible statuses: "working", "failed", "aborted", "success".
                
                // Display timestamp and status (for demo purposes)
                echo "<p>" . date(DATE_RFC2822) . ": " . $status . "</p>";
                
                if ($status == "success")
                {
                    // Display link to the file with conversion results
                    echo "<div>## Conversion Result:<a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
                    break;
                }
                else if ($status == "working")
                {
                    // Pause for a few seconds
                    sleep(3);
                }
                else 
                {
                    echo $status . "<br/>";
                    break;
                }
            }
            while (true);
        }
        else
        {
            // Display service reported error
            echo "<p>Error: " . $json["message"] . "</p>"; 
        }
    }
    else
    {
        // Display request error
        echo "<p>Status code: " . $status_code . "</p>"; 
        echo "<p>" . $result . "</p>"; 
    }
}
else
{
    // Display CURL error
    echo "Error: " . curl_error($curl);
}

// Cleanup
curl_close($curl);


function CheckJobStatus($jobId)
{
    $status = null;
    
    // Create URL
    $url = "https://api.pdf.co/v1/job/check?jobid=" . $jobId;
    
    // Create request
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey));
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    
    // Execute request
    $result = curl_exec($curl);
    
    if (curl_errno($curl) == 0)
    {
        $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        
        if ($status_code == 200)
        {
            $json = json_decode($result, true);
        
            if ($json["error"] == false)
            {
                $status = $json["status"];
            }
            else
            {
                // Display service reported error
                echo "<p>Error: " . $json["message"] . "</p>"; 
            }
        }
        else
        {
            // Display request error
            echo "<p>Status code: " . $status_code . "</p>"; 
            echo "<p>" . $result . "</p>"; 
        }
    }
    else
    {
        // Display CURL error
        echo "Error: " . curl_error($curl);
    }
    
    // Cleanup
    curl_close($curl);
    
    return $status;
}

?>

</body>
</html>
```

<!-- code block end -->