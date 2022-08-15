public class UploadFilesToPDFco {
    
    String API_KEY = '***************';  
    String[] fileName = new String[] {'images-and-documents', 'Input', 'sample1'}; // File name which is available in salesforce Files.
   
    List<String> urlList = new List<String>();
    public void startProcessing()
    {
        try
        {
            for(String fname : fileName)
            {
                ContentVersion cv = [select Title, VersionData from ContentVersion where Title = :fname limit 1];
                Blob SourceFile  = cv.VersionData;

                // 1. Prepare URL for "Get Presigned URL" API call
                string url = 'https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=:fname'; 

                HttpRequest req = new HttpRequest();
                req.setHeader('x-api-key', API_KEY);
                req.setEndpoint(url);
                req.setMethod('GET');
                req.setTimeout(60000);

                Http http = new Http();
                HTTPResponse res = http.send(req);

                if(res.getStatusCode() == 200) 
                {
                    System.Debug('res ' + res);
                    Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                    Boolean isError = Boolean.ValueOf(deserializedBody.get('error'));

                    if(isError == false)
                    {
                        // Get URL to use for the file upload
                        String uploadUrl = String.ValueOf(deserializedBody.get('presignedUrl'));

                        // 2. UPLOAD THE FILE TO CLOUD.
                        uploadFile(API_KEY, uploadUrl, SourceFile)

                        // Get URL of uploaded file 
                        String uploadedFileUrl = String.ValueOf(deserializedBody.get('url'));
                        System.debug('uploadedFileUrl :: '+uploadedFileUrl);
                    }
                }
                else
                {
                    System.debug('Error Response ' + res.getBody());
                    System.Debug(' Status ' + res.getStatus());
                    System.Debug(' Status Code' + res.getStatusCode());
                    System.Debug(' Response String' + res.toString());
                } 
            }
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
    }   
    
    @TestVisible
    public static boolean uploadFile(String API_KEY, String url, Blob sourceFile)
    {
        HttpRequest req = new HttpRequest();
        req.setHeader('x-api-key', API_KEY);
        req.setHeader('Content-Type', 'application/octet-stream');
        req.setEndpoint(url);
        req.setMethod('PUT');
        req.setTimeout(60000);
        req.setBodyAsBlob(sourceFile);

        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() == 200) 
        {
            System.Debug(res.getBody());
            return true;
        }
        else
        {
            System.debug('Error Response ' + res.getBody());
            System.Debug(' Status ' + res.getStatus());
            System.Debug(' Status Code' + res.getStatusCode());
            System.Debug(' Response String' + res.toString());
            return false;
        }
    }
}