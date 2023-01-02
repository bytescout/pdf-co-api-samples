<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://api.pdf.co/v1/pdf/classifier',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf",
    "async": false,
    "encrypt": "false",
    "inline": "true",
    "password": "",
    "profiles": ""
} ',
		CURLOPT_HTTPHEADER => array(
				'Content-Type: application/json',
				'x-api-key: YOUR_PDFCO_API_KEY'
		),
));

$response = json_decode(curl_exec($curl));

curl_close($curl);
echo "<h2>Output:</h2><pre>", var_export($response, true), "</pre>";