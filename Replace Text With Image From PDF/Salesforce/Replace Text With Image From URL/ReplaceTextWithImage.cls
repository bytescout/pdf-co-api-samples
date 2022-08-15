public class ReplaceTextWithImage {

    String API_KEY = '*************************';    
    string DestinationFile = 'resultPDFWithImage';    
    string endPointUrl = 'https://api.pdf.co/v1/pdf/edit/replace-text-with-image';
    
    public void replaceTextWithImage()
    {
        // You can also upload your own file into PDF.co and use it as url. Check "Upload File" samples for code snippets: https://github.com/bytescout/pdf-co-api-samples/tree/master/File%20Upload/    
        String jsonBody = '{ "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf", "searchString": "Your Company Name", "caseSensitive": false, "replaceImage": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png", "pages": "0", "async": false }';

        Http http = new Http();
        HttpRequest request = new HttpRequest();            
        request.setHeader('x-api-key', API_KEY);
        request.setEndpoint(endPointUrl);            
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        request.setBody(jsonBody);            
        HttpResponse response =  http.send(request);
        Map<String, Object> json = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        try
        {
            if(response.getStatusCode() == 200) 
            {
                if ((Boolean)json.get('error') == false)
                {
                    System.debug('response.getBody() :: '+response.getBody());
                    // Get URL of generated PDF file
                    String resultFileUrl =(String)json.get('url');
                    // Download generated PDF file
                    downloadFile(resultFileUrl, DestinationFile);
                    System.debug('Generated PDF file saved as \'{0}\' file.'+ DestinationFile);
                }
            }
            else
            {
                System.debug('Error Response ' + response.getBody());
                System.Debug(' Status ' + response.getStatus());
                System.Debug(' Status Code' + response.getStatusCode());
                System.Debug(' Response String' + response.toString());
            }   
        }
        catch (Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
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
}