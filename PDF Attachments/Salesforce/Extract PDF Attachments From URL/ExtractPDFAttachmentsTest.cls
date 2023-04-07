@isTest
private class ExtractPDFAttachmentsTest {

    static testMethod void testExtractPDFAttachments() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExtractPDFAttachmentsTest.ExtractPDFAttachmentsMock());
        ExtractPDFAttachments extractPDFAttachments = new ExtractPDFAttachments();
        extractPDFAttachments.extractAttachments();
        Test.stopTest();
    }

    public class ExtractPDFAttachmentsMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"count":2,"urls":["https://pdf-temp-files.s3.us-west-2.amazonaws.com/xxxxxxxxxxxxxxxxxxxxxx","https://pdf-temp-files.s3.us-west-2.amazonaws.com/yyyyyyyyyyyyyyyyyyyyyy"],"names":["test.txt","test2.txt"],"error":false,"status":200}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
