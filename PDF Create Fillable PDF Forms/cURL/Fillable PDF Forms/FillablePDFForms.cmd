curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/add' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
    "async": false,
    "encrypt": true,
    "name": "newDocument",
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf",
    "annotations":[        
       {
            "text":"sample prefilled text",
            "x": 10,
            "y": 30,
            "size": 12,
            "pages": "0-",
            "type": "TextField",
            "id": "textfield1"
        },
        {
            "x": 100,
            "y": 150,
            "size": 12,
            "pages": "0-",
            "type": "Checkbox",
            "id": "checkbox2"
        },
        {
            "x": 100,
            "y": 170,
            "size": 12,
            "pages": "0-",
            "link": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png",
            "type": "CheckboxChecked",
            "id":"checkbox3"
        }          
        
    ],
    
    "images": [
        {
            "url": "bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png",
            "x": 200,
            "y": 250,
            "pages": "0",
            "link": "www.pdf.co"
        }
        
    ]
}'