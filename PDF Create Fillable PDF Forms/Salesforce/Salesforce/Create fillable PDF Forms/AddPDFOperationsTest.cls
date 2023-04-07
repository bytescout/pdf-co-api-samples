@isTest
private class AddPDFOperationsTest {

    static testMethod void testAddPDFOperations() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AddPDFOperationsTest.AddPDFOperationsMock());
        AddPDFOperations addPDFOperations = new AddPDFOperations();
        addPDFOperations.addOperations();
        Test.stopTest();
    }

    public class AddPDFOperationsMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"success":true,"message":"PDF updated successfully","url":"https://pdf-temp-files.s3.us-west-2.amazonaws.com/xxxxxxxxxxxxxxxxxxxxxx","pagescount":1,"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
