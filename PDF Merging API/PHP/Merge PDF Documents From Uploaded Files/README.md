## How to merge PDF documents from uploaded files for PDF merging API in PHP using PDF.co Web API

### How to merge PDF documents from uploaded files for PDF merging API in PHP: Step By Step Tutorial

The documentation is designed to help you to implement the features on your side. PDF merging API in PHP can be implemented with PDF.co Web API. PDF.co Web API is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

This rich sample source code in PHP for PDF.co Web API includes the number of functions and options you should do calling the API to implement PDF merging API. Sample code in PHP is all you need. Copy-paste it to your the code editor, then add a reference to PDF.co Web API and you are ready to try it! Test PHP sample code examples whether they respond your needs and requirements for the project.

PDF.co Web API - free trial version is on available our website. Also, there are other code samples to help you with your PHP application included into trial version.

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

##### **merge-pdf.php:**
    
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Image To PDF Conversion Results</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co/documentation/api


// 1. UPLOAD FILES TO CLOUD
// If you already have direct file links, skip to Step 2.

$uploadedFiles = array();
$fileCount = count($_FILES["files"]["name"]);
if (!file_exists("./uploads")) {
    mkdir("./uploads");
}

for($i = 0; $i < $fileCount; $i++)
{
    // 1a. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
    
    // Create URL
    $url = "https://api.pdf.co/v1/file/upload/get-presigned-url" . 
        "?name=" . $_FILES["files"]["name"][$i] .
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
            
            // 1b. UPLOAD THE FILE TO CLOUD.
            
            $tmpFilePath = $_FILES["files"]["tmp_name"][$i];
            $localFile = "./uploads/" . $_FILES["files"]['name'][$i];
            move_uploaded_file($tmpFilePath, $localFile);
            
            $fileHandle = fopen($localFile, "r");
            
            curl_setopt($curl, CURLOPT_URL, $uploadFileUrl);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array("content-type: application/octet-stream"));
            curl_setopt($curl, CURLOPT_PUT, true);
            curl_setopt($curl, CURLOPT_INFILE, $fileHandle);
            curl_setopt($curl, CURLOPT_INFILESIZE, filesize($localFile));
    
            // Execute request
            curl_exec($curl);
            
            if (curl_errno($curl) == 0)
            {
                $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
                
                if ($status_code == 200)
                {
                    $uploadedFiles[] = $uploadedFileUrl;
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
            
            fclose($fileHandle);
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
    
    curl_close($curl); 
}

// 2. MERGE UPLOADED PDF DOCUMENTS

if (count($uploadedFiles) > 0) 
{
    MergePdf($apiKey, $uploadedFiles);
}


function MergePdf($apiKey, $uploadedFiles) 
{
    // Create URL
    $url = "https://api.pdf.co/v1/pdf/merge" .
        "?name=result.pdf" .
        "&url=" . join(",", $uploadedFiles);
    
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
                
                // Display link to the result document
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