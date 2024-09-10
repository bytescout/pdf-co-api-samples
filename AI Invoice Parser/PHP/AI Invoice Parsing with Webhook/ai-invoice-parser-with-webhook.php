<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AI Invoice Parser</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = "YOUR_API_KEY"; // The authentication key (API Key). Get your own by registering at https://app.pdf.co

// Direct URL of Source PDF file
// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/
$sourceURL = "https://pdfco-test-files.s3.us-west-2.amazonaws.com/document-parser/sample-invoice.pdf";

// Provide your callback URL here
// To test you can temporary callback from sites like "https://webhook.site/"
$callbackURL = "https://example.com/callback/url/you/provided";

// Create URL
$url = "https://api.pdf.co/v1/ai-invoice-parser";

// Prepare requests params
$parameters = array();
$parameters["url"] = $sourceURL;
$parameters["callback"] = $callbackURL;

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
            echo "<div>Success!</div>";
        }
        else
        {
            // Display service reported errors
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