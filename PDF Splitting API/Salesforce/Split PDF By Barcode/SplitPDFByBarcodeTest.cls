@isTest
private class SplitPDFByBarcodeTest {

    static testmethod void testSplitPDFbyBarcode()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SplitPDFByBarcodeTest.SplitPDFByBarcodeMock());
        SplitPDFByBarcode splitPdf = new SplitPDFByBarcode();
        splitPdf.splitPdfByBarcode();
        Test.stopTest();
    }
    
    static testmethod void testSplitPDFbyBarcodeForCatch()
    {
        Test.startTest();
        SplitPDFByBarcode splitPdf = new SplitPDFByBarcode();
        splitPdf.splitPdfByBarcode();
        Test.stopTest();
    }
    
    public class SplitPDFByBarcodeMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "urls": [ "https://pdf-temp-files.s3.us-west-2.amazonaws.com/FAMAJC25DIDJ69FMLTVOWJ7IL8IZVA6E/output-split-by-barcode_page1.pdf?X-Amz-Expires=3600&X-Amz-Security-Token=FwoGZXIvYXdzEG8aDNkg0DYoVoCyvF88aSKCAYgbOizJoYULBIgYUdfJgJG5Tw7PlcNavOD6q4JNwLz5wT89pkTBS%2FPbnykQjNrJeh%2B6njlDmjcLqAjt2RApVDtXFJrb%2F%2B67T43qQZJXCj83zIugG2oTGsA1tK2q7KmD8YV%2FWM%2FUEXEhiiKYXtae2GQAsMPowLTWCrw6%2BUhX8AQQjPIor42nnwYyKDAWzJatWBqURnasvqtS10U2A4EaRxD%2BrpU5dwOqWN47Dkqzq9TBfug%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHCRJF34GF/20230213/us-west-2/s3/aws4_request&X-Amz-Date=20230213T054645Z&X-Amz-SignedHeaders=host&X-Amz-Signature=d342a4a232fe62f83bd3965335128428347dbb6b9f97c71f1f17e3e42d80edcd" ], "pageCount": 10, "error": false, "status": 200, "name": "output-split-by-barcode.pdf", "credits": 350, "duration": 4809, "remainingCredits": 1165920 }';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        } 
    }
}