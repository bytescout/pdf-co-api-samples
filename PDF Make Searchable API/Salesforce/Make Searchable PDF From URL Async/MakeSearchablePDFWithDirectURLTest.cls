@isTest
private class MakeSearchablePDFWithDirectURLTest {

    @isTest static void testMakePdfTextSearchable()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MakeSearchablePDFCallOutMock());        
        MakeSearchablePDFWithDirectURL.makePdfTextSearchable();
        Test.stopTest();
    }
    
     @isTest static void testMakePdfTextSearchableForCatch()
    {
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new MakeSearchablePDFCallOutMock());        
        MakeSearchablePDFWithDirectURL.makePdfTextSearchable();
        Test.stopTest();
    }
    
    @isTest static void testSleep()
    {
        Test.startTest();
        MakeSearchablePDFWithDirectURL.sleep(3000);
        Test.stopTest();
    }
    
    public class MakeSearchablePDFCallOutMock implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{ "url": "https://pdf-temp-files.s3.amazonaws.com/a0d52f35504e47148d1771fce875db7b/result.pdf", "pageCount": 1, "error": false, "status": "success", "name": "result.pdf", "remainingCredits": 99033681, "credits": 35 } ');
            response.setStatusCode(200);
            return response; 
        }
    }
}