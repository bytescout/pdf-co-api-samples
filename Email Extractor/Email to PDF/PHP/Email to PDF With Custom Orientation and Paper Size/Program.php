<?php

$curl = curl_init();

// You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
curl_setopt_array($curl, array(
		CURLOPT_URL => 'https://api.pdf.co/v1/pdf/convert/from/email',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => '',
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => 'POST',
		CURLOPT_POSTFIELDS =>'{
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/email-to-pdf/sample.eml",
    "embedAttachments": true,
    "name": "email-with-attachments",
    "async": false,
    "encrypt": false,
    "profiles": "{\\"orientation\\": \\"landscape\\", \\"paperSize\\": \\"letter\\" }"
}',
		CURLOPT_HTTPHEADER => array(
				'Content-Type: application/json',
				'x-api-key: {{x-api-key}}'
		),
));

$response = json_decode(curl_exec($curl));

curl_close($curl);
echo "<h2>Output:</h2><pre>", var_export($response, true), "</pre>";