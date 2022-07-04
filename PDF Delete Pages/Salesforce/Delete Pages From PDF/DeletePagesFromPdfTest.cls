@isTest
private class DeletePagesFromPdfTest {

    private testmethod static void testdeletePageFromPdf()
    {
        Test.setMock(HttpCalloutMock.class, new DeletePagesFromPdfTest.DeletePageMock());
        (new DeletePagesFromPdf()).deletePageFromPdf();
        List<ContentVersion> cv = [select Id, VersionData from ContentVersion];
        System.assertEquals(1, cv.size());        
    }
    
    private  testmethod static void testdeletePageFromPdfException()
    {
        Test.setMock(HttpCalloutMock.class, new DeletePagesFromPdfTest.DeletePageMockForExp());
        (new DeletePagesFromPdf()).deletePageFromPdf();
        List<ContentVersion> cv = [select Id from ContentVersion];
        System.assertEquals(0, cv.size());
    }    
    
    public class DeletePageMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url": "https://pdf-temp-files.s3.amazonaws.com/d15e5b2c89c04484ae6ac7244ac43ac2/result.pdf", "pageCount": 2, "error": false, "status": 200, "name": "result.pdf", "remainingCredits": 60100 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class DeletePageMockForExp implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url1111": "https://pdf-temp-files.s3.amazonaws.com/d15e5b2c89c04484ae6ac7244ac43ac2/result.pdf", "pageCount": 2, "error": false, "status": 200, "name": "result.pdf", "remainingCredits": 60100 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}