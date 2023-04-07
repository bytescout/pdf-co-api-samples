@isTest
private class ReadBarcodeFromURLTest {

    static testMethod void testReadBarcodeFromURL() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ReadBarcodeFromURLTest.ReadBarcodeFromURLMock());
        ReadBarcodeFromURL readBarcodeFromURL = new ReadBarcodeFromURL();
        readBarcodeFromURL.readBarcodeFromUrl();
        Test.stopTest();
    }

    public class ReadBarcodeFromURLMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"items":[{"type":"QRCode","value":"This is a test QR Code","page":0,"rect":{"left":142,"top":181,"width":101,"height":101},"elementIndex":0,"foreColor":null,"backColor":null,"error":null,"fileIndex":0,"info":null}],"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
