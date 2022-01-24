<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF Invoice Generation Results</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co

// Data to fill the template
$templateData = file_get_contents("./invoice_data.json");


// Prepare URL for HTML to PDF API call
$url = "https://api.pdf.co/v1/pdf/convert/from/html";

// Prepare requests params
$parameters = array();
$parameters["name"] = "result.pdf";

/* 
Please follow below steps to create your own HTML Template and get "templateId". 
1. Add new html template in app.pdf.co/templates/html
2. Copy paste your html template code into this new template. Sample HTML templates can be found at "https://github.com/bytescout/pdf-co-api-samples/tree/master/PDF%20from%20HTML%20template/TEMPLATES-SAMPLES"
3. Save this new template
4. Copy it’s ID to clipboard
5. Now set ID of the template into “templateId” parameter
*/

// HTML template using built-in template
// see https://app.pdf.co/templates/html/3/edit
$parameters["template_id"] = 3;

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
            
            // Display link to the file with conversion results
            echo "<div><h2>Conversion Result:</h2><a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
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