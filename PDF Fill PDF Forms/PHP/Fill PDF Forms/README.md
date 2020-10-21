## PDF fill PDF forms in PHP and PDF.co Web API PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

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

##### **fill-pdf-forms.php:**
    
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF Fill PDF Form Results</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co/documentation/api

// Prepare URL for HTML to PDF API call
$url = "https://api.pdf.co/v1/pdf/edit/add";

// Prepare requests params
// See documentation: https://apidocs.pdf.co
$parameters = array();

// Direct URL of source PDF file.
$parameters["url"] = "bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-form/f1040.pdf";

// Name of resulting file
$parameters["name"] = "f1040-form-filled";

// If large input document, process in async mode by passing true
$parameters["async"] = false;

// Field Strings
$fields =   '[{
    "fieldName": "topmostSubform[0].Page1[0].FilingStatus[0].c1_01[1]",
    "pages": "1",
    "text": "True"
},
{
    "fieldName": "topmostSubform[0].Page1[0].f1_02[0]",
    "pages": "1",
    "text": "John A."
},        
{
    "fieldName": "topmostSubform[0].Page1[0].f1_03[0]",
    "pages": "1",
    "text": "Doe"
},        
{
    "fieldName": "topmostSubform[0].Page1[0].YourSocial_ReadOrderControl[0].f1_04[0]",
    "pages": "1",
    "text": "123456789"
},
{
    "fieldName": "topmostSubform[0].Page1[0].YourSocial_ReadOrderControl[0].f1_05[0]",
    "pages": "1",
    "text": "Joan B."
},
{
    "fieldName": "topmostSubform[0].Page1[0].YourSocial_ReadOrderControl[0].f1_05[0]",
    "pages": "1",
    "text": "Joan B."
},
{
    "fieldName": "topmostSubform[0].Page1[0].YourSocial_ReadOrderControl[0].f1_06[0]",
    "pages": "1",
    "text": "Doe"
},
{
    "fieldName": "topmostSubform[0].Page1[0].YourSocial_ReadOrderControl[0].f1_07[0]",
    "pages": "1",
    "text": "987654321"
}]';// JSON string

// Convert JSON string to Array
$fieldsArray = json_decode($fields, true);

$parameters["fields"] = $fieldsArray;

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
            echo "<div>## Result:<a href='" . $resultFileUrl . "' target='_blank'>" . $resultFileUrl . "</a></div>";
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
```

<!-- code block end -->