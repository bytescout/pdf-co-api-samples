<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF Extractor Results</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co/documentation/api
$barcodeType = $_POST["barcodeType"];
$barcodeValue = $_POST["inputValue"];

/*
 Valid error correction levels:
 ----------------------------------
 Low - [default] Lowest error correction level. (Approx. 7% of codewords can be restored).
 Medium - Medium error correction level. (Approx. 15% of codewords can be restored).
 Quarter - Quarter error correction level (Approx. 25% of codewords can be restored).
*/
// Set "Custom Profiles" parameter
$Profiles = "{ \"profiles\": [ { \"profile1\": { \"Options.QRErrorCorrectionLevel\": \"Quarter\" } } ] }";


// Create URL
$url = "https://api.pdf.co/v1/barcode/generate";

// Prepare requests params
$parameters = array();
$parameters["value"] = $barcodeValue;
$parameters["type"] = $barcodeType;
$parameters["profiles"] = $Profiles;

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
        
        if ($json["error"] == false)
        {
            $resultFileUrl = $json["url"];
            
            // Display generated image
            echo "<div><h2>Result:</h2><img src=" . $resultFileUrl . "></div>";
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