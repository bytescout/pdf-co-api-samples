@isTest
private class AddTextImageSignatureToPDFTest {

    private testmethod static void testAddSignatureToPdf()
    {
        Test.setMock(HttpCalloutMock.class, new AddTextImageSignatureToPDFTest.DocumentCreationMock());
        Test.startTest();
        AddTextImageSignatureToPDF addSign = new AddTextImageSignatureToPDF();
        addSign.addTextImageSignatureToPdf();
        Test.stopTest();
        List<ContentVersion> cv = [select Id, VersionData from ContentVersion];
        System.assertEquals(1, cv.size());
        String strt1 = cv[0].VersionData.toString();
        System.assert(strt1.contains('John A. Doe'));
    }
    
    private testmethod static void testAddSignatureToPdfForCatch()
    {
        Test.startTest();
        AddTextImageSignatureToPDF addSign = new AddTextImageSignatureToPDF();
        addSign.addTextImageSignatureToPdf();
        Test.stopTest();
    }
    
    public class DocumentCreationMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "hash": "John A. Doe", "url": "https://pdf-temp-files.s3.amazonaws.com/cd15a09771554bed88d6419c1e2f2b16/f1040-filled.pdf", "pageCount": 1, "error": false, "status": 200, "name": "f1040-filled.pdf", "remainingCredits": 99999369, "credits": 3 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}