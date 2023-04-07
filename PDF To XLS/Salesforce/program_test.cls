@isTest
private class PDFToXLSTest {

    static testMethod void testConvertPdfToXls() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToXLSMock());
        PDFToXLS pdfToXLS = new PDFToXLS();
        pdfToXLS.convertPdfToXls();
        Test.stopTest();
    }

    public class PDFToXLSMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-excel/sample.xls"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
