public class AddPDFOperations {
    
    String API_KEY = '******************';
    String endPointUrl = 'https://api.pdf.co/v1/pdf/edit/add';
    
    public void addOperations() {
        try {
            String jsonBody = '{ "async": false, "inline": true, "name": "newDocument", "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-edit/sample.pdf", "annotations": [ { "text": "sample prefilled text", "x": 10, "y": 30, "size": 12, "pages": "0-", "type": "TextField", "id": "textfield1" }, { "x": 100, "y": 150, "size": 12, "pages": "0-", "type": "Checkbox", "id": "checkbox2" }, { "x": 100, "y": 170, "size": 12, "pages": "0-", "link": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-edit/logo.png", "type": "CheckboxChecked", "id": "checkbox3" } ], "images": [ { "url": "pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-edit/logo.png", "x": 200, "y": 250, "pages": "0", "link": "www.pdf.co" } ] }';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);
            
            if(response.getStatusCode() == 200) {
                System.debug('PDF edit result: ' + response.getBody());
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