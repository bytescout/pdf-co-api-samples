<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Extract Images from PDF - Results</title>
</head>
<body>

<?php 
// Validate inputs
if (!isset($_POST["apiKey"], $_POST["pages"], $_FILES["file"]["tmp_name"])) {
    die("Error: Missing required form parameters.");
}

$apiKey = htmlspecialchars($_POST["apiKey"]);
$pages = htmlspecialchars($_POST["pages"]);
$fileName = htmlspecialchars($_FILES["file"]["name"]);
$localFile = $_FILES["file"]["tmp_name"];

// 1. Retrieve the presigned URL for file upload
$url = "https://api.pdf.co/v1/file/upload/get-presigned-url" .
    "?name=" . urlencode($fileName) .
    "&contenttype=application/octet-stream";

$curl = curl_init();
curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey));
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

$result = curl_exec($curl);
if (curl_errno($curl) == 0) {
    $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    if ($status_code == 200) {
        $json = json_decode($result, true);
        $uploadFileUrl = $json["presignedUrl"];
        $uploadedFileUrl = $json["url"];

        // 2. Upload the file to cloud
        $fileHandle = fopen($localFile, "r");
        curl_setopt($curl, CURLOPT_URL, $uploadFileUrl);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array("content-type: application/octet-stream"));
        curl_setopt($curl, CURLOPT_PUT, true);
        curl_setopt($curl, CURLOPT_INFILE, $fileHandle);
        curl_setopt($curl, CURLOPT_INFILESIZE, filesize($localFile));
        curl_exec($curl);
        fclose($fileHandle);

        if (curl_errno($curl) == 0) {
            $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
            if ($status_code == 200) {
                // 3. Extract images from the uploaded PDF
                ExtractJSON($apiKey, $uploadedFileUrl, $pages);
            } else {
                echo "<p>Status code: " . $status_code . "</p>";
                echo "<p>Error: " . $result . "</p>";
            }
        } else {
            echo "Error: " . curl_error($curl);
        }
    } else {
        echo "<p>Status code: " . $status_code . "</p>";
        echo "<p>Error: " . $result . "</p>";
    }
}

curl_close($curl);

function ExtractJSON($apiKey, $uploadedFileUrl, $pages) 
{
    $url = "https://api.pdf.co/v1/pdf/convert/to/json2";

    $parameters = array();
    $parameters["url"] = $uploadedFileUrl;
    $parameters["inline"] = true;
    $parameters["pages"] = $pages;
    $parameters["profiles"] = '{ "SaveImages": "Embed" }';
    $parameters["async"] = true; // Ensure async mode is explicitly set

    $data = json_encode($parameters);

    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey, "Content-type: application/json"));
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

    $result = curl_exec($curl);
    if (curl_errno($curl) == 0) {
        $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        if ($status_code == 200) {
            $json = json_decode($result, true);
            if (isset($json["jobId"])) {
                CheckJobStatusAndFetchResult($json["jobId"], $apiKey, $json["url"]);
            } else {
                echo "<p>Error: No job ID returned in the response.</p>";
            }
        } else {
            echo "<p>Status code: " . $status_code . "</p>";
            echo "<p>Error: " . $result . "</p>";
        }
    } else {
        echo "Error: " . curl_error($curl);
    }

    curl_close($curl);
}

function CheckJobStatusAndFetchResult($jobId, $apiKey, $jsonUrl)
{
    $url = "https://api.pdf.co/v1/job/check";
    $retryCount = 0;
    $maxRetries = 30;

    do {
        $parameters = array("jobid" => $jobId);
        $data = json_encode($parameters);

        $curl = curl_init();
        curl_setopt($curl, CURLOPT_HTTPHEADER, array("x-api-key: " . $apiKey, "Content-type: application/json"));
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

        $result = curl_exec($curl);
        if (curl_errno($curl) == 0) {
            $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
            if ($status_code == 200) {
                $json = json_decode($result, true);
                if (!isset($json["error"]) || $json["error"] == false) {
                    if ($json["status"] == "success") {
                        echo "<p>Job ID: $jobId</p>";
echo "<p>JSON URL: <a href='$jsonUrl' target='_blank'>$jsonUrl</a></p>";
if (isset($jsonUrl)) {
    $jsonContent = file_get_contents($jsonUrl);
                            echo "<pre>Extracted JSON Content: " . htmlspecialchars($jsonContent) . "</pre>";
                        } else {
                            echo "<p>Error: No URL found in the job result.</p>";
                        }
                        break;
                    } elseif ($json["status"] == "working") {
                        sleep(3);
                    } else {
                        echo "<p>Job failed with status: " . $json["status"] . "</p>";
                        break;
                    }
                } else {
                    echo "<p>Error: " . $json["message"] . "</p>";
                    break;
                }
            } else {
                echo "<p>Status code: " . $status_code . "</p>";
                echo "<p>Error: " . $result . "</p>";
                break;
            }
        } else {
            echo "Error: " . curl_error($curl);
            break;
        }

        $retryCount++;
        curl_close($curl);
    } while ($retryCount < $maxRetries);
}

?>

</body>
</html>
