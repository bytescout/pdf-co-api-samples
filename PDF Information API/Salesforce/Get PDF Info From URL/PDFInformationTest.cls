@isTest
private class PDFInformationTest {

    static testMethod void testGetPdfInfo() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFInformationTest.PDFInformationMock());
        PDFInformation pdfInformation = new PDFInformation();
        pdfInformation.getPdfInfo();
        Test.stopTest();
    }

    public class PDFInformationMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"info":{"pagecount":1,"title":"sample.pdf","subject":"","keywords":"","author":"","creator":"Microsoft Word","producer":"Microsoft Word"},"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
