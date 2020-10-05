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
            "text":"Testing, one, two, three.",
            "x": 10,
            "y": 10,
            "size": 12,
            "pages": "0-"
        },
        {
            "text":"Testing Clickable Links \r\n(CLICK ME!)",
            "x": 200,
            "y": 200,
            "size": 24,
            "pages": "0-",
            "color": "CCBBAA",
            "link": "https://bytescout.com/"
        },
      {
            "text":"Simple text label (default type)",
            "x": 100,
            "y": 100,
            "size": 12,
            "pages": "0-",
            "type": "Text"
        },
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
            "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png",
            "x": 450,
            "y": 10,
            "pages": "0"
        },
        {
            "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png",
            "x": 450,
            "y": 100,
            "width": 50,
            "height": 50,
            "pages": "0"
        },
        {
            "url": "bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png",
            "x": 200,
            "y": 250,
            "pages": "0",
            "link": "www.pdf.co"
        }
        
    ]
}'