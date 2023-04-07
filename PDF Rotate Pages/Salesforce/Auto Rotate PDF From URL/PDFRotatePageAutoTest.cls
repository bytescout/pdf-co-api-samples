@isTest
private class PDFRotatePageAutoTest {

    static testMethod void testAutoRotatePdfPages() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFRotatePageAutoTest.PDFRotatePageAutoMock());
        PDFRotatePageAuto pdfRotatePageAuto = new PDFRotatePageAuto();
        pdfRotatePageAuto.autoRotatePdfPages();
        Test.stopTest();
    }

    public class PDFRotatePageAutoMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"url":"https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-fix-rotation/rotated_pages.pdf","pages":4,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
