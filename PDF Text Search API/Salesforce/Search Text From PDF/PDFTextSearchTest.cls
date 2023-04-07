@isTest
private class PDFTextSearchTest {

    static testMethod void testSearchPdfText() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFTextSearchTest.PDFTextSearchMock());
        PDFTextSearch pdfTextSearch = new PDFTextSearch();
        pdfTextSearch.searchPdfText();
        Test.stopTest();
    }

    public class PDFTextSearchMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"foundTextItems":[{"text":"Invoice Date 12/04/2019","page":0,"x":30,"y":25,"width":200,"height":15}],"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
