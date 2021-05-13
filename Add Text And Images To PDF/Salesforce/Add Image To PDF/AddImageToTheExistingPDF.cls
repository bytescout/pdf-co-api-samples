public class AddImageToTheExistingPDF {
    
    public static void addImageToPDF()
    {
        String API_KEY = '*****************************************';        
        string SourceFileUrl = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf';
        string Pages = '';
        string Password = '';
        String DestinationFile = 'result';

        string Type1  = 'image';
        Integer X = 400;
        Integer Y = 600;
        Integer Width1  = 119;
        Integer Height1  = 32;
        String ImageUrl = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png';


        Map<string, Object> parameters = new Map<string, Object>();
        parameters.put('name', DestinationFile);
        parameters.put('password', Password);
        parameters.put('pages', Pages);
        parameters.put('url', SourceFileUrl);
        parameters.put('type', Type1);
        parameters.put('x', X);
        parameters.put('y', Y);
        parameters.put('width', Width1);
        parameters.put('height', Height1);
        parameters.put('urlimage', ImageUrl);
        
        string jsonPayload = Json.serialize(parameters);
        try
        {
            string url = 'https://api.pdf.co/v1/pdf/edit/add';
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
                System.Debug('res ' + res);
                Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                String urlVal = (String)deserializedBody.get('url');
                downloadPDFAndStore(urlVal, DestinationFile);
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

    @TestVisible
    private static void downloadPDFAndStore(String extFileUrl, String DestinationFile)
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
                conVer.PathOnClient = DestinationFile + '.pdf'; // The files name, extension is very important here which will help the file in preview.
                conVer.Title = DestinationFile; // Display name of the files
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