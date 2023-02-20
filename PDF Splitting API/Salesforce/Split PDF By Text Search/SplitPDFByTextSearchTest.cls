@isTest
private class SplitPDFByTextSearchTest {

    static testMethod void testSplitPdfUsingPage()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SplitPDFByTextSearchTest.SplitPDFByTextMock());
        SplitPDFByTextSearch splitPdf = new SplitPDFByTextSearch();
        splitPdf.splitPdfByText();
        Test.stopTest();
    }
    
    static testMethod void testSplitPdfUsingPageForCatch()
    {
        Test.startTest();
        SplitPDFByTextSearch splitPdf = new SplitPDFByTextSearch();
        splitPdf.splitPdfByText();
        Test.stopTest();
    }
    
    public class SplitPDFByTextMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{ "urls": [ "https://pdf-temp-files.s3.us-west-2.amazonaws.com/BV5R88QIPOZPKVO0PE7GYKVBETULHN0Y/invoice-extracted_page1.pdf?X-Amz-Expires=3600&X-Amz-Security-Token=FwoGZXIvYXdzEG8aDKuBm3gDES1tmO7uSSKCATaP8OHW3vpxMhhGOh4utp7hCQzkW5aPbntexlu9TwfIMzceDB6zBv%2F5L4kWTEf8xwOqTckcDrAeDd0oL%2FbWpbPgP68r01OjXwSBbB0TMu3KftSf7VN%2B7NhOl4MXX1HIOSCrvcCUvLOql2DcpVhjFwPJ%2B1JMx6yorVx1zNMLwj98Kuco%2FI6nnwYyKBbvDvsM%2FQpG1PaeKq7jq7kfl4MIt7KkwPs8LyuEMIkaLznfkdpSMFw%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHFPQ3GI5S/20230213/us-west-2/s3/aws4_request&X-Amz-Date=20230213T054546Z&X-Amz-SignedHeaders=host&X-Amz-Signature=f3d62c0952b8bc772a77c3d146b7fb55a8e86129b5cb351500f73aead8c1dbfa", "https://pdf-temp-files.s3.us-west-2.amazonaws.com/98TZ8L6PIAX3QWHF4POX4Q9TN6BHPIIH/invoice-extracted_page2.pdf?X-Amz-Expires=3600&X-Amz-Security-Token=FwoGZXIvYXdzEG8aDKuBm3gDES1tmO7uSSKCATaP8OHW3vpxMhhGOh4utp7hCQzkW5aPbntexlu9TwfIMzceDB6zBv%2F5L4kWTEf8xwOqTckcDrAeDd0oL%2FbWpbPgP68r01OjXwSBbB0TMu3KftSf7VN%2B7NhOl4MXX1HIOSCrvcCUvLOql2DcpVhjFwPJ%2B1JMx6yorVx1zNMLwj98Kuco%2FI6nnwYyKBbvDvsM%2FQpG1PaeKq7jq7kfl4MIt7KkwPs8LyuEMIkaLznfkdpSMFw%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHFPQ3GI5S/20230213/us-west-2/s3/aws4_request&X-Amz-Date=20230213T054546Z&X-Amz-SignedHeaders=host&X-Amz-Signature=98d5bf380c9176f410178b1554dae798faad7158f52153bbe1dbe1b86cb91fe7" ], "pageCount": 3, "error": false, "status": 200, "name": "invoice-extracted.pdf", "credits": 105, "duration": 465, "remainingCredits": 1166270 }';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}