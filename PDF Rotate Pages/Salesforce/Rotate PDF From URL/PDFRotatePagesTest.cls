@isTest
private class PDFRotatePagesTest {

    static testMethod void testRotatePdfPages() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFRotatePagesTest.PDFRotatePagesMock());
        PDFRotatePages pdfRotatePages = new PDFRotatePages();
        pdfRotatePages.rotatePdfPages();
        Test.stopTest();
    }

    public class PDFRotatePagesMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"url":"https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-optimize/sample.pdf","pages":4,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
