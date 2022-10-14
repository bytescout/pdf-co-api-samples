<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cloud API "Extract Email Attachment" job example (allows to avoid timeout errors).</title>
</head>
<body>

<?php 

// Cloud API asynchronous "Extract Email Attachment" job example.

// The authentication key (API Key).
// Get your own by registering at https://app.pdf.co
$apiKey = "******************************************";

// Direct URL of source file. Check another example if you need to upload a local file to the cloud.
// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
$sourceFileUrl = "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-extractor/sample.eml";

// Prepare URL for `Extract Email Attachment` API call
$url = "https://api.pdf.co/v1/email/extract-attachments";

// Prepare requests params
$parameters = array();
$parameters["url"] = $sourceFileUrl;
$parameters["inline"] = true;

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
            echo "<strong>From: </strong>" . $json["body"]["from"] . "<br />";
            echo "<strong>Subject: </strong>" . $json["body"]["subject"] . "<br />";
            echo "<strong>Body: </strong><pre>" . $json["body"]["bodyText"] . "</pre><br />";
            echo "<strong><u>Attachments</u></strong><br/>";

            foreach($json["body"]["attachments"] as $itmAttachment) {
                echo "FileName: " . $itmAttachment["filename"] . ", <a href='" . $itmAttachment["url"] ."' target='_blank'>Download</a> <br/>";
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
}
else
{
    // Display CURL error
    echo "Error: " . curl_error($curl);
}

// Cleanup
curl_close($curl);

?>

</body>
</html>