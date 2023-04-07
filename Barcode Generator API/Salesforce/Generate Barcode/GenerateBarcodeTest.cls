@isTest
private class GenerateBarcodeTest {

    static testMethod void testGenerateBarcode() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GenerateBarcodeTest.GenerateBarcodeMock());
        GenerateBarcode generateBarcode = new GenerateBarcode();
        generateBarcode.generateBarcode();
        Test.stopTest();
    }

    public class GenerateBarcodeMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"url":"https://pdf-temp-files.s3.us-west-2.amazonaws.com/barcode/barcode.png","name":"barcode.png","error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
