@isTest
private class ConvertEmailToPdfTest {

    static testmethod void testConvertEmailToPdf() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ConvertEmailToPdfTest.ConvertEmailToPdfMock());
        ConvertEmailToPdf convertEmail = new ConvertEmailToPdf();
        convertEmail.convertEmailToPdf();
        Test.stopTest();
    }

    public class ConvertEmailToPdfMock implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"url":"https://pdf-temp-files.s3.us-west-2.amazonaws.com/ESRNUYPYS5RJIOJ8MT5DL8QLNOWMT3SG/email-with-attachments.pdf?X-Amz-Expires=3600\u0026X-Amz-Security-Token=FwoGZXIvYXdzEG0aDHKmifPGIYK8lSM0gyKCAUpezMRqX46NuUtPXmG01%2F36PDGpPjXHDmQF53pRl%2Bu9DjbpnNUp0iwxssel1HzjZNklih1l1C9BXEdEKn3Zea9N3mcADliD7g6Mxb8hr1rRz79U8GI6VlHIZZVJXbPRVyUyGrY%2BiwhfgarRg%2B5lln8jHMxPiHO66HUwGGkz04G4Iaoo0pOXoAYyKHe1LuYDaSM5gunLIezTYMm2wYrjgcOTQ%2F%2B07VwIFeBRaZFclBGBqk4%3D\u0026X-Amz-Algorithm=AWS4-HMAC-SHA256\u0026X-Amz-Credential=ASIA4NRRSZPHBI7XR2FE/20230306/us-west-2/s3/aws4_request\u0026X-Amz-Date=20230306T155547Z\u0026X-Amz-SignedHeaders=host\u0026X-Amz-Signature=e7d7005e0de47b9d065339883fd54f92f1eb18e14ae836c1c84eed56838fc29c","pageCount":1,"error":false,"status":200,"name":"email-with-attachments.pdf","credits":21,"duration":255,"remainingCredits":1165585}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}
