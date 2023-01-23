@isTest
public class AddTextToExistingPDFTest
{
    private  testmethod static void testaddTextToPDF()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AddTextToExistingPDFTest.DocumentCreationMock());
        AddTextToExistingPDF addTxtToPdf = new AddTextToExistingPDF();
        addTxtToPdf.addTextToPdf();
        Test.stopTest();
    }
    
    private  testmethod static void testaddTextToPDFForCatch()
    {
        Test.startTest();
        AddTextToExistingPDF addTxtToPdf = new AddTextToExistingPDF();
        addTxtToPdf.addTextToPdf();
        Test.stopTest();
    }
    
    public class DocumentCreationMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c336bfcef1a473d98492bda25d8da03/newDocument.pdf?X-Amz-Expires=3600&x-amz-security-token=FwoGZXIvYXdzEO7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDHWK1dY4d4lOgsheliKBATwE%2FZewASPTEnPxTn%2BOdYhP4h3gljAJfqbRvQptDX7wdWLmrBS7Tg4qTU6pAbxIdXChGPjBWpSbtiADJKmqkmyhkUmE8GSM1%2FGtJO6bga2pgzvFLXmzxjTf3%2BFNqwYOvbyApIZdVLoPpEKY6PlCflQtLTd30dhelm6xpB8pitbdhSjdz8KCBjIobVy%2Fjwybwp6OQgB%2FT6QkIo2dU07gtFREdn5jhRyvnS5lkccweBV1%2Bw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHMV5P3JOS/20210316/us-west-2/s3/aws4_request&X-Amz-Date=20210316T124309Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=95287bf3c007fed4c2c5aeea1ce75c846cc6c68b22aaf35175ebe41a105f54e1", "pageCount": 1, "error": false, "status": 200, "name": "newDocument", "remainingCredits": 9913694, "credits": 3 }';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}