@isTest
private class PDFToTextTest {

    static testMethod void testConvertPdfToText() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToTextMock());
        PDFToText pdfToText = new PDFToText();
        pdfToText.convertPdfToText();
        Test.stopTest();
    }

    public class PDFToTextMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-text/sample.txt"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
