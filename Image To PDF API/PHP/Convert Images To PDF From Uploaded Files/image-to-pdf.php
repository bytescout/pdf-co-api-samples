<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Image To PDF Conversion Results</title>
</head>
<body>

<?php 

// Note: If you have input files large than 200kb we highly recommend to check "async" mode example.

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://pdf.co

// 1. UPLOAD FILES TO CLOUD
// If you already have direct file links, skip to Step 2.

$uploadedFiles = array();
$fileCount = count($_FILES["files"]["name"]);

for($i = 0; $i < $fileCount; $i++)
{
    // 1a. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.

    // Create URL
    $url = "https://api.pdf.co/v1/file/upload/get-presigned-url" . 
        "?name=" . urlencode($_FILES["files"]["name"][$i]) .
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

            $fileHandle = fopen($tmpFilePath, "r");

            curl_setopt($curl, CURLOPT_URL, $uploadFileUrl);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array("content-type: application/octet-stream"));
            curl_setopt($curl, CURLOPT_PUT, true);
            curl_setopt($curl, CURLOPT_INFILE, $fileHandle);
            curl_setopt($curl, CURLOPT_INFILESIZE, filesize($tmpFilePath));

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
                    echo "<p>Uploading File Status code: " . $status_code . " : " . $uploadedFileUrl . "</p>"; 
                    echo "<p>error status for uploading files (1 means error related to php.ini config or tmp folder permissions): " . $_FILES['files']['error'] . "</p>";
                    echo "<p>" . $result . "</p>"; 
                }
            }
            else
            {
                // Display CURL error
                echo "cURL Error: " . curl_error($curl);
            }

            fclose($fileHandle);
        }
        else
        {
            // Display request error
            echo "<p>Error Uploading: Status code: " . $status_code . "</p>"; 
            echo "<p>" . $result . "</p>"; 
        }
    }
    else
    {
        // Display CURL error
        echo "cURL Error: " . curl_error($curl);
    }

    curl_close($curl); 
}

// 2. CREATE PDF DOCUMENT FROM UPLOADED IMAGE FILES

if (count($uploadedFiles) > 0) 
{
    ImageToPdf($apiKey, $uploadedFiles);
}


function ImageToPdf($apiKey, $uploadedFiles) 
{
    // Create URL
    $url = "https://api.pdf.co/v1/pdf/convert/from/image";

    // Prepare requests params
    $parameters = array();
    $parameters["name"] = "result.pdf";
    $parameters["url"] = join(",", $uploadedFiles);

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
                $resultFileUrl = $json["url"];

                // Display link to the file with conversion results
                echo "<div>## Conversion Result:<a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
            }
            else
            {
                // Display service reported error
                echo "<p>PDF.co API execution Error: " . $json["message"] . "</p>"; 
            }
        }
        else
        {
            // Display request error
            echo "<p>API Call Status code: " . $status_code . ": " . $url . "</p>"; 
            echo "<p>" . $result . "</p>"; 
        }
    }
    else
    {
        // Display CURL error
        echo "cURL Error 2: " . curl_error($curl);
    }

    // Cleanup
    curl_close($curl);
}

?>

</body>
</html>
