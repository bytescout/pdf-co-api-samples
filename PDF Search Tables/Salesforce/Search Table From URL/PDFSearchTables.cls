public class PDFSearchTables {
    
    String API_KEY = '*********************';
    String endPointUrl = 'https://api.pdf.co/v1/pdf/find/table';
    
    public void findTablesInPdf() {
        try {
            String jsonBody = '{"url": "pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-to-text/sample.pdf", "async": "false", "inline": "true", "password": ""}';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);
            
            if(response.getStatusCode() == 200) {
                System.debug('PDF Search Tables: ' + response.getBody());
            } else {
                System.debug('Error Response ' + response.getBody());
                System.Debug(' Status ' + response.getStatus());
                System.Debug(' Status Code' + response.getStatusCode());
                System.Debug(' Response String' + response.toString());
            }
        } catch (Exception ex) {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
    }
}