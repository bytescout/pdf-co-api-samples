## How to extract line items from tables on multiple pages for document parser API in Java and PDF.co Web API What is PDF.co Web API? It is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore SDK Docs](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://pdf.co/documentation/api?utm_source=github-readme)
[Explore Web API Documentation](https://pdf.co/documentation/api?utm_source=github-readme)
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

##### **MultiPageTable-template2.yml:**
    
```
---
# Template that demonstrates parsing of multi-page table without using 
# macro expression for table rows. Rows and cells are extracted automatically 
# by specified column coordinates. Use `Template Editor` app to find the coordinates 
# (coordinates of the mouse cursor are displayed in the toolbar).
templateVersion: 3
templatePriority: 0
sourceId: Multipage Table Test
detectionRules:
  keywords:
  - Sample document with multi-page table
fields:
  total:
    type: regex
    expression: 'TOTAL{{Spaces}}({{Number}})'
    dataType: decimal
tables:
- name: table1
  # coordinate OR macro expression to find the table start on each document page
  start:
    #y: 136
    expression: 'Item{{Spaces}}Description{{Spaces}}Price'
  # coordinate OR macro expression to find the table end on each document page
  end:
    #y: 787
    expression: (Page {{Digits}} of {{Digits}})|(TOTAL{{Spaces}}{{Number}})
  # left coordinate of the table (optional)
  left: 51
  # right coordinate of the table (optional)
  right: 528
  # column names, output data types and coordinates (left column edge)
  columns: 
  - name: itemNo
    x: 51
    type: integer
  - name: description
    x: 102
    type: string
  - name: price
    x: 324
    type: decimal
  - name: qty
    x: 396
    type: integer
  - name: extPrice
    x: 441
    type: decimal
  multipage: true
```

<!-- code block end -->