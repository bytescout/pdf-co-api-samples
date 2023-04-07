@isTest
private class PDFClassifierTest {

    static testMethod void testPDFClassifier() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFClassifierTest.PDFClassifierMock());
        PDFClassifier pdfClassifier = new PDFClassifier();
        pdfClassifier.classifyPdf();
        Test.stopTest();
    }

    public class PDFClassifierMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"value":"INVOICE","confidence":0.9987059,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
