## How to create custom template for document parser API in Java using PDF.co Web API PDF.co Web API: the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

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

##### **SampleTemplate.yml:**
    
```
sourceId: My Custom Template
detectionRules:
  keywords:
  - Your Company Name
  - Invoice No\.
  - TOTAL
fields:
  total:
    expression: TOTAL {{DECIMAL}}
    type: decimal
    pageIndex: 0
  dateIssued:
    expression: Invoice Date {{DATE}}
    type: date
    dateFormat: auto-mdy
    pageIndex: 0
  invoiceId:
    expression: Invoice No. {{123}}
    pageIndex: 0
  companyName:
    expression: Vendor Company
    static: true
    pageIndex: 0
  billTo:
    rect:
    - 32.25
    - 150
    - 348
    - 70.5
    pageIndex: 0
  notes:
    rect:
    - 32.25
    - 227.25
    - 531
    - 47.25
    pageIndex: 0
tables:
- name: table1
  start:
    expression: Item\s+Quantity\s+Price\s+Total
  end:
    expression: TOTAL
  subItemStart: {}
  subItemEnd: {}
  row:
    expression: ^\s*(?<description>\w+.*)(?<quantity>\d+)\s+(?<unitPrice>\d+\.\d{2})\s+(?<itemTotal>\d+\.\d{2})\s*$


```

<!-- code block end -->