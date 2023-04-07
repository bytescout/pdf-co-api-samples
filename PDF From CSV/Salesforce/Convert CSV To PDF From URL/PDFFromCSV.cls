public class PDFFromCSV {

    String API_KEY = 'YOUR_PDF_CO_API_KEY_HERE';
    String endPointUrl = 'https://api.pdf.co/v1/pdf/convert/from/csv';

    public void convertCSVtoPDF() {
        try {
            String jsonBody = '{ "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/csv-to-pdf/sample.csv", "pages": "0-", "name": "result.pdf", "async": false }';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200) {
                System.debug('Converted PDF: ' + response.getBody());
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
