<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF Splitting Results</title>
</head>
<body>


<?php
// Get submitted form data
$apiKey = $_POST["apiKey"];
$splitText = $_POST["splitText"];

// Step 1: Retrieve the presigned URL to upload the file
$url = "https://api.pdf.co/v1/file/upload/get-presigned-url" .
    "?name=" . urlencode($_FILES["file"]["name"]) .
    "&contenttype=application/octet-stream";

// Create CURL request
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
        $accessFileUrl = $json["url"];

        // Step 2: Upload the file to the cloud
        $localFile = $_FILES["file"]["tmp_name"];
        $fileHandle = fopen($localFile, "r");

        curl_setopt($curl, CURLOPT_URL, $uploadFileUrl);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array("content-type: application/octet-stream"));
        curl_setopt($curl, CURLOPT_PUT, true);
        curl_setopt($curl, CURLOPT_INFILE, $fileHandle);
        curl_setopt($curl, CURLOPT_INFILESIZE, filesize($localFile));

        curl_exec($curl);
        fclose($fileHandle);

        if (curl_errno($curl)) {
            echo "Error uploading file: " . curl_error($curl);
        } else {
            $status_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);

            if ($status_code == 200) {
                // Step 3: Split the PDF asynchronously
                SplitPdf($apiKey, $accessFileUrl, $splitText);
            } else {
                echo "<p>Status code: " . $status_code . "</p>";
                echo "<p>Error uploading file: " . $result . "</p>";
            }
        }
    } else {
        echo "<p>Status code: " . $status_code . "</p>";
        echo "<p>Error retrieving presigned URL: " . $result . "</p>";
    }

    curl_close($curl);
} else {
    echo "Error: " . curl_error($curl);
}

function SplitPdf($apiKey, $fileUrl, $splitText) {
    $url = "https://api.pdf.co/v1/pdf/split2";

    $parameters = array(
        "name" => "split.pdf",
        "url" => $fileUrl,
        "searchString" => $splitText,
        "async" => true // Asynchronous mode
    );

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
                $jobId = $json["jobId"];
                CheckJobStatus($jobId, $apiKey);
            } else {
                echo "<p>Error: " . $json["message"] . "</p>";
            }
        } else {
            echo "<p>Status code: " . $status_code . "</p>";
            echo "<p>Error splitting PDF: " . $result . "</p>";
        }
    } else {
        echo "Error: " . curl_error($curl);
    }

    curl_close($curl);
}

function CheckJobStatus($jobId, $apiKey) {
    $url = "https://api.pdf.co/v1/job/check";

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
                    $status = $json["status"];

                    if ($status == "success") {
                        // Handle JSON file with URLs
                        $resultFileUrl = $json["url"]; // This is the JSON file containing URLs
                        $jsonFileContents = file_get_contents($resultFileUrl);

                        if ($jsonFileContents) {
                            $splitFiles = json_decode($jsonFileContents, true);

                            echo "<h3>Split PDF Results:</h3>";
                            if (is_array($splitFiles)) {
                                foreach ($splitFiles as $index => $pdfUrl) {
                                    echo "<p>Part " . ($index + 1) . ": <a href='" . htmlspecialchars($pdfUrl) . "' target='_blank'>" . htmlspecialchars($pdfUrl) . "</a></p>";
                                }
                            } else {
                                echo "<p>Error: Invalid JSON structure in the result file.</p>";
                            }
                        } else {
                            echo "<p>Error: Unable to fetch the result JSON file.</p>";
                        }
                        break;
                    } elseif ($status == "working") {
                        sleep(3); // Wait and retry
                    } else {
                        echo "<p>Job status: " . htmlspecialchars($status) . "</p>";
                        break;
                    }
                } else {
                    echo "<p>Error: " . htmlspecialchars($json["message"]) . "</p>";
                    break;
                }
            } else {
                echo "<p>Status code: " . $status_code . "</p>";
                echo "<p>Error checking job status: " . htmlspecialchars($result) . "</p>";
                break;
            }
        } else {
            echo "Error: " . curl_error($curl);
            break;
        }

        curl_close($curl);
    } while (true);
}

?>


</body>
</html>