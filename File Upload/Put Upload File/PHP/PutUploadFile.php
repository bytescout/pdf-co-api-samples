<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => "%3Cinsert%20presignedUrl%20generated%20by%20https://api.pdf.co/v1/file/upload/get-presigned-url%20%3E",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "PUT",
		CURLOPT_POSTFIELDS => array('file'=> new CURLFILE('/Users/em/Downloads/logo.png')),
		CURLOPT_HTTPHEADER => array(
				"x-api-key: {{x-api-key}}"
		),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
