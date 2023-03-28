public class PdfFromHtmlTemplate {

    String API_KEY = '************************';
    string DestinationFile = 'PdfFromHtmlTemplate'; 
    string endPointUrl = 'https://api.pdf.co/v1/pdf/convert/from/html';
    
    public void pdfFromHtml()
    {
        try
        {  
            String jsonBody = '{ "templateId": 2, "name": "newDocument.pdf", "mediaType": "print", "margins": "40px 20px 20px 20px", "paperSize": "Letter", "orientation": "Portrait", "printBackground": true, "header": "", "footer": "", "async": false, "encrypt": false, "templateData": "{\'paid\': true,\'invoice_id\': \'0021\',\'invoice_date\': \'August 29, 2041\',\'invoice_dateDue\': \'September 29, 2041\',\'issuer_name\': \'Sarah Connor\',\'issuer_company\': \'T-800 Research Lab\',\'issuer_address\': \'435 South La Fayette Park Place, Los Angeles, CA 90057\',\'issuer_website\': \'www.example.com\',\'issuer_email\': \'info@example.com\',\'client_name\': \'Cyberdyne Systems\',\'client_company\': \'Cyberdyne Systems\',\'client_address\': \'18144 El Camino Real, Sunnyvale, California\',\'client_email\': \'sales@example.com\',\'items\': [ {\'name\': \'T-800 Prototype Research\',\'price\': 1000.0 }, {\'name\': \'T-800 Cloud Sync Setup\',\'price\': 300.0 }],\'discount\': 0.1,\'tax\': 0.0725,\'note\': \'Thank you for your support of advanced robotics.\'}" } ';
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