@isTest
private class PdfFromURLTest {
    
    static testmethod void testPdfFromURL()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PdfFromURLTest.PdfFromURLMock());
        PdfFromURL obj = new PdfFromURL();
        obj.pdfFromUrl();
        Test.stopTest();
    }
    
    static testmethod void testPdfFromURLForCatch()
    {
        Test.startTest();
        PdfFromURL obj = new PdfFromURL();
        obj.pdfFromUrl();
        Test.stopTest();
    }
    
    public class PdfFromURLMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "url": "https://pdf-temp-files.s3.us-west-2.amazonaws.com/I2K4REAIUDL5VJXG3WR10SUI7WPTSLD2/newDocument.pdf?X-Amz-Expires=3600&X-Amz-Security-Token=FwoGZXIvYXdzEHAaDBbojXVomGyhj38pUSKCATL90aSv8rG9O6XHS66qBmgm%2FCnX8DpXzL1M2Zcs43pyK1dn%2Fa6TLlyUal2%2Bzda%2BipdNBljLhyjY5SXzNARe56f0AEUjEHYHfjCe6O3ejZs33WbNYD1qBfMiONcWaEA25Dt%2FV0ukP8ixVMVlbNJWGAaF6iz2Laax5NxdB3%2B3IBGBBI4oge2XoAYyKC0Q1BwVxGl78nymJAkUDDrO0WISEusfCKB4ldP%2Bv%2F2lTbef0NZSHDE%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHGEJLXAAK/20230306/us-west-2/s3/aws4_request&X-Amz-Date=20230306T155847Z&X-Amz-SignedHeaders=host&X-Amz-Signature=62cfc8ca245dee65c3aadb50e479d81c87443c031df743b841fb5e11cac87c96", "pageCount": 1, "error": false, "status": 200, "name": "newDocument.pdf", "credits": 9, "duration": 3001, "remainingCredits": 1165546 } ';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        } 
    }
}