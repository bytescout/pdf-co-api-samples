@isTest
private class SplitPDFByPageNumberTest {

    static testMethod void testSplitPdfUsingPage()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SplitPDFByPageNumberTest.SplitPDFByPageNoMock());
        SplitPDFByPageNumber splitPdf = new SplitPDFByPageNumber();
        splitPdf.splitPdfUsingPage();
        Test.stopTest();
    }
    
    static testMethod void testSplitPdfUsingPageforCatch()
    {
        Test.startTest();
        SplitPDFByPageNumber splitPdf = new SplitPDFByPageNumber();
        splitPdf.splitPdfUsingPage();
        Test.stopTest();
    }
    
    public class SplitPDFByPageNoMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "urls": [ "https://pdf-temp-files.s3.us-west-2.amazonaws.com/YPG46FWTZPJA0XOYS4WW9REHCHLO659Y/result_page1-2.pdf?X-Amz-Expires=3600&X-Amz-Security-Token=FwoGZXIvYXdzEG8aDNkg0DYoVoCyvF88aSKCAYgbOizJoYULBIgYUdfJgJG5Tw7PlcNavOD6q4JNwLz5wT89pkTBS%2FPbnykQjNrJeh%2B6njlDmjcLqAjt2RApVDtXFJrb%2F%2B67T43qQZJXCj83zIugG2oTGsA1tK2q7KmD8YV%2FWM%2FUEXEhiiKYXtae2GQAsMPowLTWCrw6%2BUhX8AQQjPIor42nnwYyKDAWzJatWBqURnasvqtS10U2A4EaRxD%2BrpU5dwOqWN47Dkqzq9TBfug%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHCRJF34GF/20230213/us-west-2/s3/aws4_request&X-Amz-Date=20230213T054449Z&X-Amz-SignedHeaders=host&X-Amz-Signature=8f5a5c43ab6aecde4deef658d5f8d93deca1cca19487453cc9fc75a09f918b8b" ], "pageCount": 4, "error": false, "status": 200, "name": "result.pdf", "credits": 8, "duration": 359, "remainingCredits": 1166375 }';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}