@isTest
private class MakeSearchablePDFWithFileUploadTest {

    @isTest static void testStartProcessing()
    {
        ContentVersion con = new ContentVersion();
        con.Title = 'sampleScannedPDF';
        con.VersionData=Blob.valueOf('Test Document');
        con.PathOnClient = 'sampleScannedPDF.pdf';
        insert con;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MakeSearchablePDFCallOutMock());
        MakeSearchablePDFWithFileUpload searchablePDF = new MakeSearchablePDFWithFileUpload();
        MakeSearchablePDFWithFileUpload.API_KEY = 'testapikey';
        searchablePDF.startProcessing();
        Test.stopTest();
        List<ContentVersion> cv = [select Id,Title from ContentVersion];
        System.assertEquals('sampleScannedPDF', cv[0].Title);
    }
    
    @isTest static void testStartProcessingForCatch()
    {
        ContentVersion con = new ContentVersion();
        con.Title = 'sampleScannedPDF';
        con.VersionData=Blob.valueOf('Test Document');
        con.PathOnClient = 'sampleScannedPDF.pdf';
        insert con;
        
        Test.startTest();
        MakeSearchablePDFWithFileUpload searchablePDF = new MakeSearchablePDFWithFileUpload();
        MakeSearchablePDFWithFileUpload.API_KEY = 'testapikey';
        searchablePDF.startProcessing();
        Test.stopTest();
        List<ContentVersion> cv = [select Id,Title from ContentVersion];
        System.assertEquals('sampleScannedPDF', cv[0].Title);
    }
    
    @isTest static void testmakePdfTextSearchableJobSuccess()
    {
        List<String> urlList = new List<String>();
        urlList.add('test');
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MakeSearchablePDFCallOutMockForCheckStatusSuccess());
        MakeSearchablePDFWithFileUpload.makePdfTextSearchable(urlList);
        Test.stopTest();
        
    }
    
    @isTest static void testmakePdfTextSearchableJobSuccessForCatch()
    {
        List<String> urlList = new List<String>();
        urlList.add('test');
        Test.startTest();
        MakeSearchablePDFWithFileUpload.makePdfTextSearchable(urlList);
        Test.stopTest();
    }
    
    @isTest static void testSleep()
    {
        Test.startTest();
        MakeSearchablePDFWithFileUpload.sleep(3000);
        Test.stopTest();
    }
    
    public class MakeSearchablePDFCallOutMock implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"presignedUrl":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host&X-Amz-Signature=8650913644b6425ba8d52b78634698e5fc8970157d971a96f0279a64f4ba87fc","url": "https://pdf-temp-files.s3.amazonaws.com/a0d52f35504e47148d1771fce875db7b/test.pdf", "pageCount": 1, "error": false, "Status": 200, "name": "test.pdf", "remainingCredits": 99033681, "credits": 35 } ');
            response.setStatusCode(200);
            return response; 
        }
    }
    
    public class MakeSearchablePDFCallOutMockForCheckStatusSuccess implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{ "status": "success", "remainingCredits": 60227,"url": "https://pdf-temp-files.s3.amazonaws.com/a0d52f35504e47148d1771fce875db7b/result.pdf" } ');
            response.setStatusCode(200);
            return response; 
        }
    }
}