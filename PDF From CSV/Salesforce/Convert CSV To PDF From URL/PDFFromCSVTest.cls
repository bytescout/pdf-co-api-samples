@isTest
private class PDFFromCSVTest {

    static testMethod void testPDFFromCSV() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFFromCSVTest.PDFFromCSVMock());
        PDFFromCSV pdfFromCSV = new PDFFromCSV();
        pdfFromCSV.convertCSVtoPDF();
        Test.stopTest();
    }

    public class PDFFromCSVMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"url":"https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-converted/sample.pdf","message":"PDF Created","error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
