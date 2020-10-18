<?php

$curl = curl_init();

curl_setopt_array($curl, array(
		CURLOPT_URL => "https://api.pdf.co/v1/file/upload/url",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
		CURLOPT_POSTFIELDS => array('name' => 'sample.pdf','url' => 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf'),
		CURLOPT_HTTPHEADER => array(
				"x-api-key: {{x-api-key}}"
		),
));

$response = curl_exec($curl);

curl_close($curl);
echo $response;
