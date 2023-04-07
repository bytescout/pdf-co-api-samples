@isTest
private class RenderUrlAsJpgTest {

    static testMethod void testRenderUrlAsJpg() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new RenderUrlAsJpgMock());
        RenderUrlAsJpg renderUrlAsJpg = new RenderUrlAsJpg();
        renderUrlAsJpg.renderUrlAsJpg();
        Test.stopTest();
    }

    public class RenderUrlAsJpgMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-image/sample.jpg"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
