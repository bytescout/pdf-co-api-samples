## How to convert PDF to CSV asynchronously for PDF to CSV API in PHP and PDF.co Web API

### Learn how to convert PDF to CSV asynchronously to have PDF to CSV API in PHP

Today we will explain the steps and algorithm of how to convert PDF to CSV asynchronously and how to make it work in your application. PDF.co Web API was made to help with PDF to CSV API in PHP. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

PHP code snippet like this for PDF.co Web API works best when you need to quickly implement PDF to CSV API in your PHP application. Follow the instruction and copy - paste code for PHP into your project's code editor. Use of PDF.co Web API in PHP is also explained in the documentation included along with the product.

Our website provides free trial version of PDF.co Web API that includes source code samples to help with your PHP project.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore SDK Docs](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Documentation](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### ****pdf-to-csv-async.php:**
    
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cloud API asynchronous "PDF To CSV" job example (allows to avoid timeout errors).</title>
</head>
<body>

<?php 

// Cloud API asynchronous "PDF To CSV" job example.
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


// Prepare URL for `PDF To CSV` API call
$url = "https://api.pdf.co/v1/pdf/convert/to/csv" . 
    "?url=" . $sourceFileUrl .
    "&password=" . $password .
    "&pages=" . $pages .
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
            // URL of generated CSV file that will available after the job completion
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