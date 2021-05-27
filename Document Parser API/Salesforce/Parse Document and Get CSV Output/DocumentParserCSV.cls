public class DocumentParserCSV {
    
    public void startProcessing()
    {
        try
        {
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('url', 'https://bytescout-com.s3-us-west-2.amazonaws.com/files/demo-files/cloud-api/document-parser/sample-invoice.pdf');
            gen.writeStringField('templateId', '1');
            gen.writeStringField('outputFormat', 'CSV');
            gen.writeStringField('generateCsvHeaders', 'true');
            
            gen.writeBooleanField('async', false);
            gen.writeStringField('encrypt', 'false');
            gen.writeStringField('inline', 'true');
            gen.writeStringField('password', '');
            gen.writeBooleanField('storeResult', false);
            
            gen.writeEndObject();
            
            // Convert dictionary of params to JSON
            String jsonPayload = gen.getAsString();
            String url = 'https://api.pdf.co/v1/pdf/documentparser';
            HttpResponse response =  API.postCall(url, jsonPayload, 'application/json');    
            
            Map<String, Object> json = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            
            if(response.getStatusCode() == 200) 
            {
                if ((Boolean)json.get('error') == false)
                {
                    // Get URL of generated PDF file
                    String jsonBody =(String)json.get('body');
                    SYstem.Debug(jsonBody);
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