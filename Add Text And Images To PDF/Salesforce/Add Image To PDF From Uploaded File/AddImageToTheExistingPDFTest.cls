@isTest
public class AddImageToTheExistingPDFTest
{
    private  testmethod static void testaddImageToPDF()
    {
        List<ContentVersion> cvList = new List<ContentVersion>();
        ContentVersion con = new ContentVersion();
        con.Title = 'samplePDF';
        con.VersionData=Blob.valueOf('images-and-documents');
        con.PathOnClient = 'samplePDF.pdf';
        cvList.add(con);
        
        ContentVersion con1 = new ContentVersion();
        con1.Title = 'logo_byte';
        con1.VersionData=Blob.valueOf('image');
        con1.PathOnClient = 'logo_byte.png';
        cvList.add(con1);
        insert cvList;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AddImageToTheExistingPDFTest.DocumentCreationMockForUpload());
        AddImageToTheExistingPDF addImageToPdf = new AddImageToTheExistingPDF();
        addImageToPdf.startProcessing();
        List<ContentVersion> cv = [select Id from ContentVersion];
        Test.stopTest();
        System.assertEquals(3, cv.size());
    }
    
    
    public class DocumentCreationMockForUpload implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"presignedUrl":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host&X-Amz-Signature=8650913644b6425ba8d52b78634698e5fc8970157d971a96f0279a64f4ba87fc","url":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=3600&x-amz-security-token=FwoGZXIvYXdzEGgaDA9KaTOXRjkCdCqSTCKBAW9tReCLk1fVTZBH9exl9VIbP8Gfp1pE9hg6et94IBpNamOaBJ6%2B9Vsa5zxfiddlgA%2BxQ4tpd9gprFAxMzjN7UtjU%2B2gf%2FKbUKc2lfV18D2wXKd1FEhC6kkGJVL5UaoFONG%2Fw2jXfLxe3nCfquMEDo12XzcqIQtNFWXjKPWBkQEvmii4tfTyBTIot4Na%2BAUqkLshH0R7HVKlEBV8btqa0ctBjwzwpWkoU%2BF%2BCtnm8Lm4Eg%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHEGHTOA4W/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=243419ac4a9a315eebc2db72df0817de6a261a684482bbc897f0e7bb5d202bb9","error":false,"status":200,"name":"test.pdf","remainingCredits":98145}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
}