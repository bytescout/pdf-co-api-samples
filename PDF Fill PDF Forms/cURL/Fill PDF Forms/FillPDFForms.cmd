curl --location --request POST 'https://api.pdf.co/v1/pdf/edit/add' \
--header 'Content-Type: application/json' \
--header 'x-api-key: {{x-api-key}}' \
--data-raw '{
    "async": false,
    "encrypt": false,
    "name": "f1040-filled",
    "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-form/f1040.pdf",
    "fields": [
        {
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
        }     



    ],
    "annotations":[
        {
            "text":"Sample Filled with PDF.co API using /pdf/edit/add. Get fields from forms using /pdf/info/fields",
            "x": 10,
            "y": 10,
            "size": 12,
            "pages": "0-",
            "color": "FFCCCC",
            "link": "https://pdf.co"
        }
    ],    
    "images": [        
    ]
}'