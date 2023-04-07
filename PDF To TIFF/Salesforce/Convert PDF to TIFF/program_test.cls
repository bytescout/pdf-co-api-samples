@isTest
private class PDFToTIFFTest {

    static testMethod void testConvertPdfToTiff() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFToTIFFMock());
        PDFToTIFF pdfToTIFF = new PDFToTIFF();
        pdfToTIFF.convertPdfToTiff();
        Test.stopTest();
    }

    public class PDFToTIFFMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"url":"https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-image/sample-0.tiff","pageCount":1,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
