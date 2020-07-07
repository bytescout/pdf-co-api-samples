## document parser API in Java and PDF.co Web API PDF.co Web API is the Rest API that provides set of data extraction functions, tools for documents manipulation, splitting and merging of pdf files. Includes built-in OCR, images recognition, can generate and read barcodes from images, scans and pdf.

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

##### **SampleTicket.yml:**
    
```
templateVersion: 3
templatePriority: 0
sourceId: MakeMyTrip Booking
detectionRules:
  keywords:
  - MakeMyTrip
  - Eticket-Dom-Flight
fields:
  BookingNo:
    type: rectangle
    rectangle:
    - 198.75
    - 85.625
    - 96.875
    - 12.500001
    pageIndex: 0
  BookingDate:
    type: rectangle
    dataType: date
    rectangle:
    - 133.125
    - 97.5000076
    - 78.75
    - 12.500001
    pageIndex: 0
  DepartureFrom:
    type: rectangle
    rectangle:
    - 153
    - 176
    - 77
    - 8.5
    pageIndex: 0
  ArrivalTo:
    type: rectangle
    rectangle:
    - 285
    - 176
    - 84
    - 8.5
    pageIndex: 0
  DepartureAt:
    type: rectangle
    dataType: date
    rectangle:
    - 153.75
    - 187.5
    - 123.75
    - 10.625
    pageIndex: 0
  ArrivalAt:
    type: rectangle
    dataType: date
    rectangle:
    - 288.125
    - 186.875
    - 125.625008
    - 11.25
    pageIndex: 0
  FlightType:
    type: rectangle
    rectangle:
    - 433.5
    - 159.5
    - 68
    - 10.5
    pageIndex: 0
  FlightDuration:
    type: rectangle
    rectangle:
    - 474.375031
    - 170.625
    - 30.0000019
    - 10
    pageIndex: 0
  CabinType:
    type: rectangle
    rectangle:
    - 463.125031
    - 194.375015
    - 51.25
    - 10
    pageIndex: 0
  PassengerName:
    type: rectangle
    rectangle:
    - 85
    - 238.125
    - 93.125
    - 14.375
    pageIndex: 0
  PassengerType:
    type: rectangle
    rectangle:
    - 229.375015
    - 238.125
    - 31.25
    - 13.75
    pageIndex: 0
  AirlinePNR:
    type: rectangle
    rectangle:
    - 375
    - 240.000015
    - 46.25
    - 13.75
    pageIndex: 0


```

<!-- code block end -->