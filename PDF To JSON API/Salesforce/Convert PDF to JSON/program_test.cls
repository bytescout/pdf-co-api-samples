@isTest
private class PDFToJSONTest {

    static testMethod void testConvertPdfToJson() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToJSONMock());
        PDFToJSON pdfToJSON = new PDFToJSON();
        pdfToJSON.convertPdfToJson();
        Test.stopTest();
    }

    public class PDFToJSONMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-json/sample.json" }';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
