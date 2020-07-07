## How to generate PDF invoice from HTML template for HTML to PDF API in PHP and PDF.co Web API

### Step By Step Tutorial: how to generate PDF invoice from HTML template for HTML to PDF API in PHP

On this page you will learn from code samples for programming in PHP. PDF.co Web API was made to help with HTML to PDF API in PHP. PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

PHP code snippet like this for PDF.co Web API works best when you need to quickly implement HTML to PDF API in your PHP application. For implimentation of this functionality, please copy and paste code below into your app using code editor. Then compile and run your app. Use of PDF.co Web API in PHP is also explained in the documentation included along with the product.

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

##### **generate-invoice.php:**
    
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF Invoice Generation Results</title>
</head>
<body>

<?php 

// Get submitted form data
$apiKey = $_POST["apiKey"]; // The authentication key (API Key). Get your own by registering at https://app.pdf.co/documentation/api

// HTML template
$template = file_get_contents("./invoice_template.html");
// Data to fill the template
$templateData = file_get_contents("./invoice_data.json");


// Prepare URL for HTML to PDF API call
$url = "https://api.pdf.co/v1/pdf/convert/from/html?name=result.pdf";

// Create HTML to PDF options
$data = json_encode(array(
    "html" => utf8_encode($template),
    "templateData" => utf8_encode($templateData)
    ));

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


?>

</body>
</html>
```

<!-- code block end -->    

<!-- code block begin -->

##### **invoice_data.json:**
    
```
{
    "number": "1234567",
    "date": "April 30, 2016",
    "from": "Acme Inc., City, Street 3rd , +1 888 123-456, support@example.com",
    "to": "Food Delivery Inc., New York, Some Street, 42",
    "lines": [{
        "title": "Setting up new web-site",
        "quantity": 3,
        "price": 50
    }, {
        "title": "Configuring mail server and mailboxes",
        "quantity": 5,
        "price": 50
    }]
}
```

<!-- code block end -->