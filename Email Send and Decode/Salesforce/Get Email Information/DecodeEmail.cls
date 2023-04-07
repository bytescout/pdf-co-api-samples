public class DecodeEmail {

    String API_KEY = 'YOUR_API_KEY_HERE';
    string endPointUrl = 'https://api.pdf.co/v1/email/decode';

    public void decodeEmail()
    {
        try
        {
            String jsonBody = '{ "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/email-extractor/sample.eml", "inline": true, "async": false }';
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
}
