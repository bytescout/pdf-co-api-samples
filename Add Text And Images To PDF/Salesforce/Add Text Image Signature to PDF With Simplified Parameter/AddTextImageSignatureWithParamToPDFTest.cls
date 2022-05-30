@isTest
private class AddTextImageSignatureWithParamToPDFTest {

    private testmethod static void testAddTxtImgSignToPdf()
    {
        Test.setMock(HttpCalloutMock.class, new AddTextImageSignatureWithParamToPDFTest.AddTxtSignMock());
        Test.startTest();
        AddTextImageSignatureWithParamToPDF addSign = new AddTextImageSignatureWithParamToPDF();
        addSign.addTextImageSignatureToPdf();
        Test.stopTest();
        List<ContentVersion> cv = [select Id, VersionData from ContentVersion];
        System.assertEquals(1, cv.size());
        //String strt1 = cv[0].VersionData.toString();
        //System.assert(strt1.contains('John A. Doe'));
    }
    
    private testmethod static void testAddTxtImgSignToPdfForException()
    {
        Test.startTest();
        AddTextImageSignatureWithParamToPDF addSign = new AddTextImageSignatureWithParamToPDF();
        addSign.addTextImageSignatureToPdf();
        Test.stopTest();        
    }
    
    public class AddTxtSignMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url": "https://pdf-temp-files.s3.amazonaws.com/03c5c55183c74f8d94a4ec952e4e32ad/f1040-form-filled.pdf", "pageCount": 3, "error": false, "status": 200, "name": "f1040-form-filled", "remainingCredits": 60822 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}