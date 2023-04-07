@isTest
private class SendEmailWithAttachmentTest {

    static testMethod void testSendEmailWithAttachment() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendEmailWithAttachmentTest.SendEmailWithAttachmentMock());
        SendEmailWithAttachment sendEmail = new SendEmailWithAttachment();
        sendEmail.sendEmailWithAttachment();
        Test.stopTest();
    }

    public class SendEmailWithAttachmentMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"error": false, "status": 200, "message": "Email sent successfully"}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
