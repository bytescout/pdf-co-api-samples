@isTest
private class PDFToXMLTest {

    static testMethod void testConvertPdfToXml() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToXMLMock());
        PDFToXML pdfToXML = new PDFToXML();
        pdfToXML.convertPdfToXml();
        Test.stopTest();
    }

    public class PDFToXMLMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-xml/sample.xml"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
