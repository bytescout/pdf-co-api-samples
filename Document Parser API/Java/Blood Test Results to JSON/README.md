## document parser API in Java and PDF.co Web API PDF.co Web API is the Web API with a set of tools for documents manipulation, data conversion, data extraction, splitting and merging of documents. Includes image recognition, built-in OCR, barcode generation and barcode decoders to decode bar codes from scans, pictures and pdf.

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

##### **SampleBloodReport.yml:**
    
```
templateVersion: 3
templatePriority: 0
sourceId: BloodTestTemplate
detectionRules:
  keywords: []
fields:
  PatientName:
    type: rectangle
    rectangle:
    - 177.75
    - 123.75
    - 62.25
    - 12.75
    pageIndex: 0
  ReportName:
    type: rectangle
    expression: '{{SmartDate}}'
    dataType: date
    rectangle:
    - 335.25
    - 94.5
    - 65.25
    - 12
    pageIndex: 0
  TestResults:
    type: rectangle
    dataType: table
    rectangle:
    - 41.25
    - 261.75
    - 532.5
    - 450.75
    pageIndex: 0
    rowMergingRule: byBorders


```

<!-- code block end -->