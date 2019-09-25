## How to PDF make searchable API in PHP with PDF.co Web API

### The tutorial shows how to PDF make searchable API in PHP

Sample source code below will show you how to cope with a difficult task like PDF make searchable API in PHP. What is PDF.co Web API? It is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf. It can help you to PDF make searchable API in your PHP application.

Fast application programming interfaces of PDF.co Web API for PHP plus the instruction and the code below will help you quickly learn how to PDF make searchable API. In order to implement the functionality, you should copy and paste this code for PHP below into your code editor with your app, compile and run your application. This basic programming language sample code for PHP will do the whole work for you to PDF make searchable API.

Free trial version of PDF.co Web API is available on our website. Documentation and source code samples are included.

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

##### ****make-pdf-searchable.php:**
    
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Make PDF Searchable Results</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co/documentation/api
$pages = $_POST["pages"];
$ocrLanguage = $_POST["ocrLanguage"];


// 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
// * If you already have the direct PDF file link, go to the step 3.

// Create URL
$url = "https://api.pdf.co/v1/file/upload/get-presigned-url" . 
    "?name=" . $_FILES["file"]["name"] .
    "&contenttype=application/octet-stream";
    
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
        
        // Get URL to use for the file upload
        $uploadFileUrl = $json["presignedUrl"];
        // Get URL of uploaded file to use with later API calls
        $uploadedFileUrl = $json["url"];
        
        // 2. UPLOAD THE FILE TO CLOUD.
        
        $localFile = $_FILES["file"]["tmp_name"];
        $fileHandle = fopen($localFile, "r");
        
        curl_setopt($curl, CURLOPT_URL, $uploadFileUrl);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array("content-type: application/octet-stream"));
        curl_setopt($curl, CURLOPT_PUT, true);
        curl_setopt($curl, CURLOPT_INFILE, $fileHandle);
        curl_setopt($curl, CURLOPT_INFILESIZE, filesize($localFile));

        // Execute request
        curl_exec($curl);
        
        fclose($fileHandle);
        
        if (curl_errno($curl) == 0)
        {
            $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
            
            if ($status_code == 200)
            {
                // 3. MAKE UPLOADED PDF FILE SEARCHABLE
                
                MakePdfSearchable($apiKey, $uploadedFileUrl, $pages, $ocrLanguage);
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
    }
    else
    {
        // Display service reported error
        echo "<p>Status code: " . $status_code . "</p>"; 
        echo "<p>" . $result . "</p>"; 
    }
    
    curl_close($curl);
}
else
{
    // Display CURL error
    echo "Error: " . curl_error($curl);
}

function MakePdfSearchable($apiKey, $uploadedFileUrl, $pages, $ocrLanguage) 
{
    // Prepare URL for `Make Searchable PDF` API call
    $url = "https://api.pdf.co/v1/pdf/makesearchable" . 
        "?name=result.pdf" .
        "&url=" . $uploadedFileUrl .
        "&pages=" . $pages . 
        "&lang=" . $ocrLanguage;
    
    // Create request
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey));
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, true);
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
                $resultFileUrl = $json["url"];
                
                // Display link to the result file
                echo "<div>## Conversion Result:<a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
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
}

?>

</body>
</html>
```

<!-- code block end -->