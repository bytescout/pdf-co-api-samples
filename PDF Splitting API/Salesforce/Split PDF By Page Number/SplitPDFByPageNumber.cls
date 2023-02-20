public class SplitPDFByPageNumber {

    String API_KEY = '***********************';
    string DestinationFile = 'SplitPDFByPageNo_Result'; 
    string endPointUrl = 'https://api.pdf.co/v1/pdf/split';
    
    public void splitPdfUsingPage()
    {
        List<ContentVersion> toBeInserted = new List<ContentVersion>();
        try
        {
            String jsonBody = '{"url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-split/sample.pdf", "pages": "1-2,3-", "inline": true, "name": "result.pdf", "async": false }';
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
                    List<Object> resultFileUrl =(List<Object>)json.get('urls');
                    Integer count=1;
                    for(Object fileUrl : resultFileUrl)
                    {
                        downloadFile(String.valueOf(fileUrl), DestinationFile+'_'+count, toBeInserted);
                        count++;
                    }                    
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
            if(toBeInserted.size() > 0)
                insert toBeInserted;
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
    }
    
    @TestVisible
    private static void downloadFile(String extFileUrl, String DestinationFile, List<ContentVersion> toBeInserted)
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
            toBeInserted.add(conVer);
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