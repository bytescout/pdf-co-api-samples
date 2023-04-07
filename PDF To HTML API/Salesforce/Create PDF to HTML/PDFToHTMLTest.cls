@isTest
private class PDFToHTMLTest {

    static testMethod void testConvertPdfToHtml() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToHTMLTest.PDFToHTMLMock());
        PDFToHTML pdfToHtml = new PDFToHTML();
        pdfToHtml.convertPdfToHtml();
        Test.stopTest();
    }

    public class PDFToHTMLMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"name":"result.html","url":"https://test-url.com/result.html","error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
