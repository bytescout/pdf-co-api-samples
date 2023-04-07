public class SendEmailWithAttachment {

    String API_KEY = 'YOUR_PDF_CO_API_KEY_HERE';
    String endPointUrl = 'https://api.pdf.co/v1/email/send';

    public void sendEmailWithAttachment() {
        try {
            String jsonBody = '{ "url": "https://pdfco-test-files.s3.us-west-2.amazonaws.com/pdf-info/sample.pdf", "from": "John Doe <john@example.com>", "to": "Partner <partner@example.com>", "subject": "Check attached sample pdf", "bodytext": "Please check the attached pdf", "bodyHtml": "Please check the attached pdf", "smtpserver": "smtp.gmail.com", "smtpport": "587", "smtpusername": "my@gmail.com", "smtppassword": "app specific password created as https://support.google.com/accounts/answer/185833", "async": false }';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setHeader('x-api-key', API_KEY);
            request.setEndpoint(endPointUrl);
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);

            if(response.getStatusCode() == 200) {
                System.debug('Email sent successfully: ' + response.getBody());
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
