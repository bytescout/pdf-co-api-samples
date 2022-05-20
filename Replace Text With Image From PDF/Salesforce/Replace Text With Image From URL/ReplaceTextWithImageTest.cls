@isTest
private class ReplaceTextWithImageTest {

    private testmethod static void testReplaceTextWithImage()
    {
        Test.setMock(HttpCalloutMock.class, new ReplaceTextWithImageTest.ReplaceTextMock());
        (new ReplaceTextWithImage()).replaceTextWithImage();
        List<ContentVersion> cv = [select Id, VersionData from ContentVersion];
        System.assertEquals(1, cv.size());
    }
    
    private  testmethod static void testReplaceTextWithImageException()
    {
        Test.setMock(HttpCalloutMock.class, new ReplaceTextWithImageTest.ReplaceTextMockForExp());
        (new ReplaceTextWithImage()).replaceTextWithImage();
        List<ContentVersion> cv = [select Id from ContentVersion];
        System.assertEquals(0, cv.size());
    }
    
    public class ReplaceTextMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url": "https://pdf-temp-files.s3.amazonaws.com/7ea2b532988742508906cff59be0180e/sample.pdf", "pageCount": 1, "error": false, "status": 200, "name": "sample.pdf", "remainingCredits": 99150679, "credits": 77 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class ReplaceTextMockForExp implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url1111": "https://pdf-temp-files.s3.amazonaws.com/7ea2b532988742508906cff59be0180e/sample.pdf", "pageCount": 1, "error": false, "status": 200, "name": "sample.pdf", "remainingCredits": 99150679, "credits": 77 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}