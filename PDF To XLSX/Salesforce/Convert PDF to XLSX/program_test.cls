@isTest
private class PDFToXLSXTest {

    static testMethod void testConvertPdfToXlsx() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToXLSXMock());
        PDFToXLSX pdfToXLSX = new PDFToXLSX();
        pdfToXLSX.convertPdfToXlsx();
        Test.stopTest();
    }

    public class PDFToXLSXMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-excel/sample.xlsx"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
