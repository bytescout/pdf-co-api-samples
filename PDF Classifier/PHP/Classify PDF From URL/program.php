<?php

$curl = curl_init();

// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
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
    "rulescsv": "Amazon,Amazon Web Services Invoice|Amazon CloudFront\\nDigital Ocean,DigitalOcean|DOInvoice\\nAcme,ACME Inc.|1540 Long Street, Jacksonville, 32099",
    "caseSensitive": "true",
    "async": false,
    "encrypt": "false",
    "inline": "true",
    "password": "",
    "profiles": ""
} ',
	CURLOPT_HTTPHEADER => array(
		'Content-Type: application/json',
		'x-api-key: '
	),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;

