public with sharing class GeneratePDFFromHTML {
    
    static String API_KEY = '"*****************************************';
    @TestVisible
    String fileName = 'SampleHTMLDocument';
    string destinationFile = 'generatedPDFFromHTML.pdf';
    public void GeneratePDFFileFromHTML()
    {
        try
        {
            ContentVersion cv = [select Title, VersionData from ContentVersion where Title = :fileName limit 1];
            String body = cv.VersionData.toString();
            Map<string, Object> parameters = new Map<string, Object>();
            parameters.put('html', body);
            parameters.put('name', destinationFile);
            parameters.put('margins', '5px 5px 5px 5px');
            parameters.put('paperSize', 'Letter');
            parameters.put('orientation', 'Portrait');
            parameters.put('printBackground', true);
            parameters.put('asyncy', false);
            parameters.put('header', '');
            parameters.put('footer', '');
            string jsonPayload = Json.serialize(parameters);
        
            string url = 'https://api.pdf.co/v1/pdf/convert/from/html';
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
                    String urlVal = (String)deserializedBody.get('url');
                    downloadPDFAndStore(urlVal, DestinationFile);
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