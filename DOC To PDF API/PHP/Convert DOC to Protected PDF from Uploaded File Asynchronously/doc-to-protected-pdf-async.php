<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DOC To PDF Conversion Results</title>
</head>
<body>

<?php 

// Note: If you have input files large than 200kb we highly recommend to check "async" mode example.

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co


// 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
// * If you already have the direct PDF file link, go to the step 3.

// Create URL
$url = "https://api.pdf.co/v1/file/upload/get-presigned-url" . 
    "?name=" . urlencode($_FILES["file"]["name"]) .
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
        
        if (!isset($json["error"]) || $json["error"] == false)
        {
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
                    // 3. CONVERT UPLOADED DOC FILE TO PDF
                    
                    DocToPdf($apiKey, $uploadedFileUrl, '');
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
            echo "<p>Error: " . $json["message"] . "</p>"; 
        }
    }
    else
    {
        // Display request error
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

function DocToPdf($apiKey, $uploadedFileUrl, $pages) 
{

    
    // Create URL
    $url = "https://api.pdf.co/v1/pdf/convert/from/doc";
    
    // Prepare requests params
    $parameters = array();
    $parameters["url"] = $uploadedFileUrl;
    $parameters["pages"] = $pages;


    // Create Json payload
    $data = json_encode($parameters);

    // Create request
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey, "Content-type: application/json"));
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

    // Execute request
    $result = curl_exec($curl);
    
    if (curl_errno($curl) == 0)
    {
        $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        
        if ($status_code == 200)
        {
            $json = json_decode($result, true);
            
            if (!isset($json["error"]) || $json["error"] == false)
            {
                $convertedFileUrl = $json["url"];
                ProtectPdf($apiKey, $convertedFileUrl);
                // // Display link to the file with conversion results
                // echo "<div><h2>Conversion Result:</h2><a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
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
function ProtectPdf($apiKey, $convertedFileUrl) 
{
    // Passwords to protect PDF document
    // The owner password will be required for document modification.
    // The user password only allows to view and print the document.
    $OwnerPassword = "123456";
    $UserPassword = "654321";

    // Encryption algorithm. 
    // Valid values: "RC4_40bit", "RC4_128bit", "AES_128bit", "AES_256bit".
    $EncryptionAlgorithm = "AES_128bit";

    // Allow or prohibit content extraction for accessibility needs.
    $AllowAccessibilitySupport = true;

    // Allow or prohibit assembling the document.
    $AllowAssemblyDocument = true;

    // Allow or prohibit printing PDF document.
    $AllowPrintDocument = true;

    // Allow or prohibit filling of interactive form fields (including signature fields) in PDF document.
    $AllowFillForms = true;

    // Allow or prohibit modification of PDF document.
    $AllowModifyDocument = true;

    // Allow or prohibit copying content from PDF document.
    $AllowContentExtraction = true;

    // Allow or prohibit interacting with text annotations and forms in PDF document.
    $AllowModifyAnnotations = true;

    // Allowed printing quality.
    // Valid values: "HighResolution", "LowResolution"
    $PrintQuality = "HighResolution";

    // Prepare URL for `PDF Security` API call
    $url = "https://api.pdf.co/v1/pdf/security/add";

    // (!) Make asynchronous job
    $async = TRUE;

    
    // Prepare requests params
    $parameters = array();
    $parameters["async"] = "$async";
    $parameters["name"] = "result.pdf";
    $parameters["url"] = $convertedFileUrl;
    $parameters["ownerPassword"] = $OwnerPassword;
    $parameters["userPassword"] = $UserPassword;
    $parameters["encryptionAlgorithm"] = $EncryptionAlgorithm;
    $parameters["allowAccessibilitySupport"] = $AllowAccessibilitySupport;
    $parameters["allowAssemblyDocument"] = $AllowAssemblyDocument;
    $parameters["allowPrintDocument"] = $AllowPrintDocument;
    $parameters["allowFillForms"] = $AllowFillForms;
    $parameters["allowModifyDocument"] = $AllowModifyDocument;
    $parameters["allowContentExtraction"] = $AllowContentExtraction;
    $parameters["allowModifyAnnotations"] = $AllowModifyAnnotations;
    $parameters["printQuality"] = $PrintQuality;

    // Create Json payload
    $data = json_encode($parameters);

    // Create request
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey, "Content-type: application/json"));
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

    // Execute request
    $result = curl_exec($curl);
    echo $result . "<br/>";

    if (curl_errno($curl) == 0)
    {
        $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        
        if ($status_code == 200)
        {
            $json = json_decode($result, true);
        
            if (!isset($json["error"]) || $json["error"] == false)
            {
                // URL of generated JSON file that will available after the job completion
                $resultFileUrl = $json["url"];
                // Asynchronous job ID
                $jobId = $json["jobId"];
                
                // Check the job status in a loop
                do
                {
                    $status = CheckJobStatus($jobId, $apiKey); // Possible statuses: "working", "failed", "aborted", "success".
                    
                    // Display timestamp and status (for demo purposes)
                    echo "<p>" . date(DATE_RFC2822) . ": " . $status . "</p>";
                    
                    if ($status == "success")
                    {
                        // Display link to JSON file with information about parsed fields
                        echo "<div><h2>Parsing Result:</h2><a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
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
}

function CheckJobStatus($jobId, $apiKey)
{
    $status = null;
    
	// Create URL
    $url = "https://api.pdf.co/v1/job/check";
    
    // Prepare requests params
    $parameters = array();
    $parameters["jobid"] = $jobId;

    // Create Json payload
    $data = json_encode($parameters);

    // Create request
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey, "Content-type: application/json"));
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
    
    // Execute request
    $result = curl_exec($curl);
    
    if (curl_errno($curl) == 0)
    {
        $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        
        if ($status_code == 200)
        {
            $json = json_decode($result, true);
        
            if (isset($json["error"]) && $json["error"] == true)
            {
                // Display service reported error
                echo "<p>Error: " . $json["message"] . "</p>"; 
            }
            else
            {
                $status = $json["status"];
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