@isTest
private class MergeDocumentsToPDFTest {
    private static testmethod void MergeDocToPDFTest(){
        Test.setMock(HttpCalloutMock.class, new MergeDocToPDF());
        Test.startTest();
        MergeDocumentsToPDF mdp = new MergeDocumentsToPDF();
		mdp.MergeDocToPDF();        
        Test.stopTest();
    }
    
    private static testmethod void MergeDocToPDFTestforCatch(){
        Test.startTest();       
        MergeDocumentsToPDF mdp = new MergeDocumentsToPDF();
		mdp.MergeDocToPDF();        
        Test.stopTest();    
    }
    
    private static testmethod void downloadPDFAndStoreTest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MergeDocumentsToPDFMcok.MergeDocToPDF());
        MergeDocumentsToPDF.downloadPDFAndStore('https://pdf-temp-files.s3.amazonaws.com/3ec287356c0b4e02b5231354f94086f2/result.pdf', 'result.pdf');        
        Test.stopTest();
    }
    
    private static testmethod void downloadPDFAndStoreTestforCatch(){
        Test.startTest();        
        MergeDocumentsToPDF.downloadPDFAndStore(null, null);        
        Test.stopTest();
    }
    
    public class MergeDocToPDF implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req) {
            String testBody = '{"url":"https://pdf-temp-files.s3.amazonaws.com/839a4e2f10e249739ed0c167b453e36b/multipagedInvoiceWithQRCode.pdf","pageCount":1,"error":false,"status":200,"name":"newDocument","remainingCredits":9913694,"credits":3}';
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json;charset=UTF-8');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }

}