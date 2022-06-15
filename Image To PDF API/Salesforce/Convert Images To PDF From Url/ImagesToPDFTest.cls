@isTest
private class ImagesToPDFTest {
    private static testMethod void testaddImageToPDF(){
        Test.setMock(HttpCalloutMock.class, new ImagesToPDFMock());
        Test.startTest();
        ImagesToPDF.addImageToPDF();
        Test.stopTest();
    }
    
    private static testMethod void testaddImageToPDFForCatch(){
        Test.startTest();
        ImagesToPDF.addImageToPDF();
        Test.stopTest();
    }
    
    private static testMethod void testaddImageToPDFForDownloadMehtod(){
        Test.setMock(HttpCalloutMock.class, new ImagesToPDFMock());
        Test.startTest();
        ImagesToPDF.downloadPDFAndStore('https://api.pdf.co/v1/pdf/convert/from/image', 'result');
        Test.stopTest();
    }
    
    public class ImagesToPDFMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
            return res;
        }
    }
}