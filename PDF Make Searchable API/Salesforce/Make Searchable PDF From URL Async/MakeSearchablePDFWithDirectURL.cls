public class MakeSearchablePDFWithDirectURL {
    public static String API_KEY = '*************';
    public static string DestinationFile = 'Searchable PDF(Using direct Url)';    
    
    public static void makePdfTextSearchable()
    {
        string SourceFileUrl = 'https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-make-searchable/sample.pdf'; 
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
                System.debug('urlVal >>> '+urlVal);
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