@isTest
private class RenderUrlAsPngTest {

    static testMethod void testRenderUrlAsPng() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new RenderUrlAsPngMock());
        RenderUrlAsPng renderUrlAsPng = new RenderUrlAsPng();
        renderUrlAsPng.renderUrlAsPng();
        Test.stopTest();
    }

    public class RenderUrlAsPngMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"status": 200, "error": false, "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-image/sample.png"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
