@isTest
private class PDFSearchTablesTest {

    static testMethod void testFindTablesInPdf() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new PDFSearchTablesTest.PDFSearchTablesMock());
        PDFSearchTables pdfSearchTables = new PDFSearchTables();
        pdfSearchTables.findTablesInPdf();
        Test.stopTest();
    }

    public class PDFSearchTablesMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"tables":[{"page":0,"x":18.5,"y":26.5,"width":200,"height":100},{"page":1,"x":18.5,"y":26.5,"width":200,"height":100}],"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
