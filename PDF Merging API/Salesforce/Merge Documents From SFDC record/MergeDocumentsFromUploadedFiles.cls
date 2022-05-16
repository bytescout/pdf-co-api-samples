public class MergeDocumentsFromUploadedFiles {
    
    String API_KEY = '***************';  
    String[] fileName = new String[] {'images-and-documents', 'Input', 'sample1'}; // File name which is available in salesforce Files.
    string destinationFile =  'MergeResultByUpload'; //This is the Desitantion File Name.
   
    List<String> urlList = new List<String>();
    public void startProcessing()
    {
        try
        {
            for(String fname : fileName)
            {
                ContentVersion cv = [select Title, VersionData from ContentVersion where Title = :fname limit 1];
                Blob SourceFile  = cv.VersionData;
                //1. Prepare URL for "Get Presigned URL" API call
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
                        // Get URL of uploaded file to use with later API calls
                        String uploadedFileUrl = String.ValueOf(deserializedBody.get('url'));
                        SYstem.debug('uploadedFileUrl :: '+uploadedFileUrl);
                        // 2. UPLOAD THE FILE TO CLOUD.
                        if(uploadFile(API_KEY, uploadUrl, SourceFile))
                        {
                            // Merge Documents and download
                            urlList.add(uploadedFileUrl);  
                            System.debug('urlList ' + urlList);
                            //System.assert(false, ' urlList ' + urlList);
                        }
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
            if (urlList.size() > 0)
            {                
                // 2. MERGE UPLOADED PDF DOCUMENTS
                MergeDocToPDF(urlList);
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
    
    public void MergeDocToPDF(List<String> uploadedFileUrl)
    {
        try
        {
            string filesUrl = string.join(uploadedFileUrl,',');            
            Map<string, Object> parameters = new Map<string, Object>();
            parameters.put('url', filesUrl);
            string jsonPayload = Json.serialize(parameters);
            
            string url = 'https://api.pdf.co/v1/pdf/merge2';
            HttpRequest req1 = new HttpRequest();
            req1.setBody(jsonPayload);
            req1.setHeader('x-api-key', API_KEY);
            req1.setHeader('Content-Type', 'application/json');
            req1.setEndpoint(url);
            req1.setMethod('POST');
            req1.setTimeout(60000);
            Http http = new Http();
            HTTPResponse res1 = http.send(req1);
            if(res1.getStatusCode() == 200) 
            {
                Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res1.getBody());
                Boolean isError = Boolean.ValueOf(deserializedBody.get('error'));
                if(isError == false)
                {
                    SYstem.debug('res1.getBody() :: '+res1.getBody());
                    String urlVal = (String)deserializedBody.get('url');
                    downloadPDFAndStore(urlVal, destinationFile);
                }
            }
            else
            {
                System.debug('Success Response ' + res1.getBody());
                System.Debug(' Status ' + res1.getStatus());
                System.Debug(' Status Code' + res1.getStatusCode());
                System.Debug(' Status String' + res1.toString());
            }
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
    }
    
    @TestVisible
    private static void downloadPDFAndStore(String extFileUrl, String DestinationFile)
    {
        Http h = new Http(); 
        HttpRequest req = new HttpRequest(); 
        extFileUrl = extFileUrl.replace(' ', '%20'); 
        req.setEndpoint(extFileUrl); 
        req.setMethod('GET'); 
        req.setHeader('Content-Type', 'application/pdf');
        req.setCompressed(true); 
        req.setTimeout(60000); 
        //Now Send HTTP Request
        HttpResponse res  = h.send(req); 
        if(res.getStatusCode() == 200) 
        {
            blob fileContent = res.getBodyAsBlob();
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
            conVer.PathOnClient = 'result' + '.pdf'; // The files name, extension is very important here which will help the file in preview.
            conVer.Title = DestinationFile; // Display name of the files
            conVer.VersionData = fileContent;
            insert conVer;
            System.Debug('Success');
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