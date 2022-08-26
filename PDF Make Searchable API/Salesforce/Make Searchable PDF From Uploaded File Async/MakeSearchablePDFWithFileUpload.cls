public class MakeSearchablePDFWithFileUpload {
    public static String API_KEY = '**************************';
    public static string DestinationFile = 'Searchable PDF(Using File Upload)';    
    String[] fileName = new String[] {'sampleScannedPDF'};
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
                            urlList.add(uploadedFileUrl);  
                            System.debug('urlList ' + urlList);                           
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
                makePdfTextSearchable(urlList);
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
    
    public static void makePdfTextSearchable(List<String> uploadedFileUrl)
    {
        System.debug('uploadedFileUrlList[0] :: '+uploadedFileUrl[0]);
        string SourceFileUrl = uploadedFileUrl[0]; 
        Map<string, Object> parameters = new Map<string, Object>();
        parameters.put('async', 'true');
        parameters.put('password', '');
        parameters.put('name', 'result.pdf');
        parameters.put('pages', '');        
        parameters.put('lang', 'eng');
        parameters.put('url', SourceFileUrl);
        string jsonPayload = Json.serialize(parameters); 
        try
        {    
            string url = 'https://api.pdf.co/v1/pdf/makesearchable';
            HttpRequest req = new HttpRequest();
            req.setBody(jsonPayload);
            req.setHeader('x-api-key', API_KEY);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(url);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200) 
            {
                System.Debug('res.getBody()' + res.getBody());
                Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                String urlVal = (String)deserializedBody.get('url');
                String jobId = (String)deserializedBody.get('jobId');
                SYstem.debug('urlVal >>> '+urlVal);
                do
                {
                    String statusVal = checkJobStatus(jobId);
                    if(statusVal == 'success')
                    {
                        downloadFile(urlVal, DestinationFile);   
                        break;
                    } 
                    else if(statusVal == 'working')
                    {
                        sleep(3000);
                    }
                    else
                    {
                        break;
                    }                        
                }while(true);
            }
            else
            {
                System.debug('Success Response ' + res.getBody());
                System.Debug(' Status ' + res.getStatus());
                System.Debug(' Status Code' + res.getStatusCode());
                System.Debug(' Status String' + res.toString());
            }
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }        
    }    
    
    
    public static String checkJobStatus(String jobId)
    {
        String statusVal;
        try
        {            
            string url = 'https://api.pdf.co/v1/job/check?jobid=' + jobId;
            HttpRequest req = new HttpRequest();
            req.setHeader('x-api-key', API_KEY);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(url);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200) 
            {
                System.Debug('res ' + res.getBody());
                Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                statusVal = (String)deserializedBody.get('status');                
            }
            else
            {
                System.debug('Success Response ' + res.getBody());
                System.Debug(' Status ' + res.getStatus());
                System.Debug(' Status Code' + res.getStatusCode());
                System.Debug(' Status String' + res.toString());
            }            
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
        return statusVal;
    }
    
    @TestVisible
    private static void downloadFile(String extFileUrl, String DestinationFile)
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
    
    public static void sleep(integer milliseconds) 
    {
        Long timeDiff = 0;
        DateTime firstTime = System.now();
        do {
            timeDiff = System.now().getTime() - firstTime.getTime();
        }
        while(timeDiff <= milliseconds);      
    }
}