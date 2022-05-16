public class MergeDocumentsToPDF {
    
    static String API_KEY = '********************';    
    string destinationFile = 'MergeResultByURL';
    public void MergeDocToPDF()
    {
        try
        {
            Map<string, Object> parameters = new Map<string, Object>();
            parameters.put('url', 'https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf,https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/other/Input.xls, https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-merge/images-and-documents.zip');
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
    private static void downloadPDFAndStore(String extFileUrl, String destinationFile)
    {
        try
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
                conVer.Title = destinationFile; // Display name of the files
                conVer.VersionData = fileContent;
                insert conVer;
                System.Debug('Success');
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
}