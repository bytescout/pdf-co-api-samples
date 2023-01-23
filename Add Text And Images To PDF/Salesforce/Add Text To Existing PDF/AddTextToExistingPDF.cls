public class AddTextToExistingPDF {
    
    String API_KEY = '******************************';    
    string DestinationFile = 'Result_AddTxtToPDF.pdf';    
    string endPointUrl = 'https://api.pdf.co/v1/pdf/edit/add'; 
    
    public void addTextToPdf()
    { 
        try
        {  
            String jsonBody = '{"async": false, "encrypt": true, "inline": true, "name": "newDocument", "url": "https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf", "annotations": [ { "text": "Sample Text 1", "x": 150, "y": 100, "size": 20, "pages": "0-" }, { "text": "Sample Text 2 - Click here to test link", "x": 100, "y": 240, "size": 24, "pages": "0-", "color": "CCBBAA", "link": "https://bytescout.com/", "fontName": "Comic Sans MS", "fontItalic": true, "fontBold": true, "fontStrikeout": false, "fontUnderline": true }]}';
            // Create HTTP client instance
            Http http = new Http();
            HttpRequest request = new HttpRequest();            
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);            
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');            
            request.setBody(jsonBody);            
            HttpResponse response =  http.send(request);            
            Map<String, Object> json = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());            
            if(response.getStatusCode() == 200) 
            {
                if ((Boolean)json.get('error') == false)
                {
                    System.debug('response.getBody() :: '+response.getBody());
                    String resultFileUrl =(String)json.get('url');
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
        HttpResponse res  = h.send(req); 
        if(res.getStatusCode() == 200) 
        {
            blob fileContent = res.getBodyAsBlob();
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; 
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