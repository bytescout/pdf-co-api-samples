## How to parse from URL asynchronously for document parser API in Java with PDF.co Web API PDF.co Web API: the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

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

##### **ByteScoutWebApiExample.iml:**
    
```
<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output />
    <content url="file://$MODULE_DIR$">
      <sourceFolder url="file://$MODULE_DIR$/src" isTestSource="false" />
    </content>
    <orderEntry type="inheritedJdk" />
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="com.google.code.gson:gson:2.8.1" level="project" />
    <orderEntry type="library" name="com.squareup.okhttp3:okhttp:3.8.1" level="project" />
  </component>
</module>
```

<!-- code block end -->    

<!-- code block begin -->

##### **MultiPageTable-template1.yml:**
    
```
---
# Template that demonstrates parsing of multi-page table using only 
# macro expressions for the table start, end, and rows.
# If macro expression cannot be written for every table row (for example, 
# if the table contains empty cells), try the second method demonstrated 
# in `MultiPageTable-template2.yml` template.
templateVersion: 3
templatePriority: 0
sourceId: Multipage Table Test
detectionRules:
  keywords:
  - Sample document with multi-page table
fields:
  total:
    expression: 'TOTAL{{Spaces}}({{Number}})'
    dataType: decimal
tables:
- name: table1
  start:
    # macro expression to find the table start in document
    expression: 'Item{{Spaces}}Description{{Spaces}}Price'
  end:
    # macro expression to find the table end in document
    expression: 'TOTAL{{Spaces}}{{Number}}'
  row:
    # macro expression to find table rows
    expression: '{{LineStart}}{{Spaces}}(?<itemNo>{{Digits}}){{Spaces}}(?<description>{{SentenceWithSingleSpaces}}){{Spaces}}(?<price>{{Number}}){{Spaces}}(?<qty>{{Digits}}){{Spaces}}(?<extPrice>{{Number}})'
  # output data types for columns
  columns: 
  - name: itemNo
    type: integer
  - name: description
    type: string
  - name: price
    type: decimal
  - name: qty
    type: integer
  - name: extPrice
    type: decimal
  multipage: true
```

<!-- code block end -->    

<!-- code block begin -->

##### **result.json:**
    
```
{
  "objects": [
    {
      "name": "total",
      "objectType": "field",
      "value": 450.00,
      "pageIndex": 1,
      "rectangle": [
        0.0,
        0.0,
        0.0,
        0.0
      ]
    },
    {
      "objectType": "table",
      "name": "table1",
      "rows": [
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 1
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 1"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 2
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 2"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 3
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 3"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 4
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 4"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 5
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 5"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 6
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 6"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 7
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 7"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 8
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 8"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 9
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 9"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 10
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 10"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 11
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 11"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 12
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 12"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 13
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 13"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 14
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 14"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 15
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 15"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 16
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 16"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 17
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 17"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 18
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 18"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 19
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 19"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 20
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 20"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 21
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 21"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 22
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 22"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 23
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 23"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 24
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 24"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 25
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 25"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 26
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 26"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 27
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 27"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 28
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 28"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 29
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 29"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 0,
            "value": 30
          },
          "description": {
            "pageIndex": 0,
            "value": "Item 30"
          },
          "price": {
            "pageIndex": 0,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 0,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 0,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 31
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 31"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 32
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 32"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 33
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 33"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 34
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 34"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 35
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 35"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 36
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 36"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 37
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 37"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 38
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 38"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 39
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 39"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 40
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 40"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 41
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 41"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 42
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 42"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 43
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 43"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 44
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 44"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        },
        {
          "itemNo": {
            "pageIndex": 1,
            "value": 45
          },
          "description": {
            "pageIndex": 1,
            "value": "Item 45"
          },
          "price": {
            "pageIndex": 1,
            "value": 10.00
          },
          "qty": {
            "pageIndex": 1,
            "value": 1
          },
          "extPrice": {
            "pageIndex": 1,
            "value": 10.00
          }
        }
      ]
    }
  ],
  "templateName": "Multipage Table Test",
  "templateVersion": "4",
  "timestamp": "2020-05-18T12:00:37"
}

```

<!-- code block end -->