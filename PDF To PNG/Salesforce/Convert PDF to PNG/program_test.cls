@isTest
private class PDFToPNGTest {

    static testMethod void testConvertPdfToPng() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToPNGMock());
        PDFToPNG pdfToPNG = new PDFToPNG();
        pdfToPNG.convertPdfToPng();
        Test.stopTest();
    }

    public class PDFToPNGMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"url":"https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-image/sample-0.png","pageCount":1,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
