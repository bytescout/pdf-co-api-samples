@isTest
private class PDFFormsInfoReaderTest {

    static testMethod void testPDFFormsInfoReader() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFFormsInfoReaderTest.PDFFormsInfoReaderMock());
        PDFFormsInfoReader pdfFormsInfoReader = new PDFFormsInfoReader();
        pdfFormsInfoReader.readFormFields();
        Test.stopTest();
    }

    public class PDFFormsInfoReaderMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"fields":[{"name":"topmostSubform[0].Page1[0].F1040[0].topmostSubform[0].Page1[0].p1-t1[0]","value":"John Doe"}],"message":"Form fields info","error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
