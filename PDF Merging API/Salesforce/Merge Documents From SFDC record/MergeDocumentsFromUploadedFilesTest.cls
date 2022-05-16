@isTest
private class MergeDocumentsFromUploadedFilesTest {

    private static testmethod void MergeDocToPDFTest(){
        List<ContentVersion> cvList = new List<ContentVersion>();
        ContentVersion con = new ContentVersion();
        con.Title = 'images-and-documents';
        con.VersionData=Blob.valueOf('images-and-documents');
        con.PathOnClient = 'images-and-documents.zip';
        cvList.add(con);
        
        ContentVersion con1 = new ContentVersion();
        con1.Title = 'Input';
        con1.VersionData=Blob.valueOf('Input');
        con1.PathOnClient = 'Input.xls';
        cvList.add(con1);
        
        ContentVersion con2 = new ContentVersion();
        con2.Title = 'sample1';
        con2.VersionData=Blob.valueOf('sample1');
        con2.PathOnClient = 'sample1.pdf';
        cvList.add(con2);
        
        insert cvList;
        
        Test.setMock(HttpCalloutMock.class, new MergeDocToPDFMock());
        Test.startTest();
        MergeDocumentsFromUploadedFiles mdp = new MergeDocumentsFromUploadedFiles();
		mdp.startProcessing();        
        Test.stopTest();
    }
    
    
    private static testmethod void MergeDocToPDFTestforCatch(){
        Test.startTest();       
        MergeDocumentsFromUploadedFiles mdp = new MergeDocumentsFromUploadedFiles();
		mdp.startProcessing();        
        Test.stopTest();    
    }
    
    private static testmethod void downloadPDFAndStoreTest(){
        Test.setMock(HttpCalloutMock.class, new MergeDocToPDFMock());
        Test.startTest();
        MergeDocumentsFromUploadedFiles.downloadPDFAndStore('https://pdf-temp-files.s3.amazonaws.com/3ec287356c0b4e02b5231354f94086f2/result.pdf', 'result.pdf');        
        Test.stopTest();
    }
    
    private static testmethod void downloadPDFAndStoreTestforCatch(){
        Test.setMock(HttpCalloutMock.class, new MergeDocToPDFMock());
        Test.startTest();        
        List<String> fileUrl = new List<String>();
        fileUrl.add('https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf');
        MergeDocumentsFromUploadedFiles mergeDoc = new MergeDocumentsFromUploadedFiles();
        mergeDoc.MergeDocToPDF(fileUrl);        
        Test.stopTest();
    }
    
    private static testmethod void uploadFileforElse(){
        Test.setMock(HttpCalloutMock.class, new MergeDocToPDFMockForError());
        Test.startTest();
        Blob sourceFile= Blob.valueOf('testData');
        MergeDocumentsFromUploadedFiles.uploadFile('testAPI', 'testUrl', sourceFile);        
        Test.stopTest();
    }
    
    private static testmethod void MergeDocToPDFTestforCatch1(){
        Test.startTest(); 
        List<String> fileUrl = new List<String>();
        fileUrl.add('https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf');
        MergeDocumentsFromUploadedFiles mdp = new MergeDocumentsFromUploadedFiles();
		mdp.MergeDocToPDF(fileUrl);        
        Test.stopTest();    
    }
    
    public class MergeDocToPDF implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req) {
            String testBody = '{"url":"https://pdf-temp-files.s3.amazonaws.com/3ec287356c0b4e02b5231354f94086f2/result.pdf","error":false,"status":200,"name":"result.pdf","remainingCredits":98465}';
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json;charset=UTF-8');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class MergeDocToPDFMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"presignedUrl":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host&X-Amz-Signature=8650913644b6425ba8d52b78634698e5fc8970157d971a96f0279a64f4ba87fc","url":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=3600&x-amz-security-token=FwoGZXIvYXdzEGgaDA9KaTOXRjkCdCqSTCKBAW9tReCLk1fVTZBH9exl9VIbP8Gfp1pE9hg6et94IBpNamOaBJ6%2B9Vsa5zxfiddlgA%2BxQ4tpd9gprFAxMzjN7UtjU%2B2gf%2FKbUKc2lfV18D2wXKd1FEhC6kkGJVL5UaoFONG%2Fw2jXfLxe3nCfquMEDo12XzcqIQtNFWXjKPWBkQEvmii4tfTyBTIot4Na%2BAUqkLshH0R7HVKlEBV8btqa0ctBjwzwpWkoU%2BF%2BCtnm8Lm4Eg%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHEGHTOA4W/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=243419ac4a9a315eebc2db72df0817de6a261a684482bbc897f0e7bb5d202bb9","error":false,"status":200,"name":"test.pdf","remainingCredits":98145}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class MergeDocToPDFMockForError implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            String testBody = '{"presignedUrl":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host&X-Amz-Signature=8650913644b6425ba8d52b78634698e5fc8970157d971a96f0279a64f4ba87fc","url":"https://pdf-temp-files.s3-us-west-2.amazonaws.com/0c72bf56341142ba83c8f98b47f14d62/test.pdf?X-Amz-Expires=3600&x-amz-security-token=FwoGZXIvYXdzEGgaDA9KaTOXRjkCdCqSTCKBAW9tReCLk1fVTZBH9exl9VIbP8Gfp1pE9hg6et94IBpNamOaBJ6%2B9Vsa5zxfiddlgA%2BxQ4tpd9gprFAxMzjN7UtjU%2B2gf%2FKbUKc2lfV18D2wXKd1FEhC6kkGJVL5UaoFONG%2Fw2jXfLxe3nCfquMEDo12XzcqIQtNFWXjKPWBkQEvmii4tfTyBTIot4Na%2BAUqkLshH0R7HVKlEBV8btqa0ctBjwzwpWkoU%2BF%2BCtnm8Lm4Eg%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHEGHTOA4W/20200302/us-west-2/s3/aws4_request&X-Amz-Date=20200302T143951Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=243419ac4a9a315eebc2db72df0817de6a261a684482bbc897f0e7bb5d202bb9","error":false,"status":200,"name":"test.pdf","remainingCredits":98145}';
            res.setHeader('Content-Type', 'application/json');
            res.setBody(testBody);
            res.setStatusCode(201);
            return res;
        }
    }

}