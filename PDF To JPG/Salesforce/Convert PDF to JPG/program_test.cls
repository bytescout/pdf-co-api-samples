@isTest
private class PDFToJPGTest {

    static testMethod void testConvertPdfToJpg() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToJPGMock());
        PDFToJPG pdfToJPG = new PDFToJPG();
        pdfToJPG.convertPdfToJpg();
        Test.stopTest();
    }

    public class PDFToJPGMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"url":"https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-image/sample.jpg","pageCount":1,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
