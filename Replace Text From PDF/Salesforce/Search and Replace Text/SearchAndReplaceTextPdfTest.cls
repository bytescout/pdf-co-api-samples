@isTest
private class SearchAndReplaceTextPdfTest {

    private testmethod static void testSearchAndReplaceText()
    {
        Test.setMock(HttpCalloutMock.class, new SearchAndReplaceTextPdfTest.ReplaceTextMock());
        (new SearchAndReplaceTextPdf()).searchAndReplaceText();
        List<ContentVersion> cv = [select Id, VersionData from ContentVersion];
        System.assertEquals(1, cv.size());
    }
    
    private  testmethod static void testReplaceTextWithImageException()
    {
        Test.setMock(HttpCalloutMock.class, new SearchAndReplaceTextPdfTest.ReplaceTextMockForExp());
        (new SearchAndReplaceTextPdf()).searchAndReplaceText();
        List<ContentVersion> cv = [select Id, VersionData from ContentVersion];
        System.assertEquals(0, cv.size());
    }
    
    public class ReplaceTextMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url": "https://pdf-temp-files.s3.amazonaws.com/1a0e9a51e2d04fe4bcce0a6a31c365a8/finalFile.pdf", "pageCount": 4, "error": false, "status": 200, "name": "finalFile", "remainingCredits": 98310 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class ReplaceTextMockForExp implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url111111": "https://pdf-temp-files.s3.amazonaws.com/1a0e9a51e2d04fe4bcce0a6a31c365a8/finalFile.pdf", "pageCount": 4, "error": false, "status": 200, "name": "finalFile", "remainingCredits": 98310 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}