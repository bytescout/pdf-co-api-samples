public class ReadBarcodeFromURL {

    String API_KEY = 'YOUR_PDF_CO_API_KEY';
    String endPointUrl = 'https://api.pdf.co/v1/barcode/read/from/url';

    public void readBarcodeFromUrl() {
        try {
            String jsonBody = '{ "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/barcode-reader/sample.pdf", "types": "QRCode,Code128,Code39,Interleaved2of5,EAN13", "pages": "0", "encrypt": false, "async": false }';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200) {
                System.debug('Barcodes read from URL: ' + response.getBody());
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
