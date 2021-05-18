 public class RemoveProtectionFromPDF {
    
    String API_KEY = '"*****************************************';

    String fileName = 'sample'; // File name "sample.pdf" which is available in Files.
    string DestinationFile =  'result.pdf'; //This is the Desitantion File Name.

    // The owner/user password to open file and to remove security features
    string PDFFilePassword = 'admin@123';

    public void startProcessing()
    {
        ContentVersion cv = [select Title, VersionData from ContentVersion where Title = :fileName limit 1];
        Blob SourceFile  = cv.VersionData;
        
        try
        {
            //1. Prepare URL for "Get Presigned URL" API call
            string url = 'https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=:fileName'; 
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
                    // 2. UPLOAD THE FILE TO CLOUD.
                    if(uploadFile(API_KEY, uploadUrl, SourceFile))
                    {
                        // 3. Remove Password Protection from Uploaded file and download.
                        RemovePasswordProtectionFromInputPDF(API_KEY, DestinationFile, uploadedFileUrl, PDFFilePassword);
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
            System.Debug(res);
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
    
    public static void RemovePasswordProtectionFromInputPDF(String API_KEY, String DestinationFile, String uploadedFileUrl, String PDFFilePassword)
    {
        Map<string, object> parameters = new Map<string, object>();
        parameters.put('name', DestinationFile);
        parameters.put('url', uploadedFileUrl);
        parameters.put('password', PDFFilePassword);

        string jsonPayload = Json.serialize(parameters);
        String url = 'https://api.pdf.co/v1/pdf/security/remove';
        
        HttpRequest req = new HttpRequest();
        req.setHeader('x-api-key', API_KEY);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setTimeout(60000);
        req.setBody(jsonPayload);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200) 
        {
            System.Debug(res);
            Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            Boolean isError = Boolean.ValueOf(deserializedBody.get('error'));
            if(isError == false)
            {
                String resultFileUrl = String.ValueOf(deserializedBody.get('url'));
                downloadPDFAndStore(resultFileUrl, DestinationFile);
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
            conVer.PathOnClient = DestinationFile + '.pdf'; // The files name, extension is very important here which will help the file in preview.
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