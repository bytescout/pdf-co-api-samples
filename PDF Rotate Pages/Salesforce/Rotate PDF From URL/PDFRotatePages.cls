public class PDFRotatePages {

    String API_KEY = 'YOUR_PDF_CO_API_KEY_HERE';
    String endPointUrl = 'https://api.pdf.co/v1/pdf/edit/rotate';

    public void rotatePdfPages() {
        try {
            String jsonBody = '{ "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-optimize/sample.pdf", "name": "result.pdf", "angle": 90, "pages": "0-2,4" }';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200) {
                System.debug('PDF Rotate Pages: ' + response.getBody());
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
