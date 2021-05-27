public class API {
    
    public static String  API_KEY = '********************************';
    
    //Get Call
    public static HttpResponse  getCall(String endPointURL)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Set the key in header.
        request.setHeader('x-api-key', API_KEY);
        //Set the URL to invoke
        request.setEndpoint(endPointURL); 
        //Sets the type of method to be used for the HTTP request.
        request.setMethod('GET');
        /*
        The timeout is the maximum time to wait for establishing the HTTP connection.
        The same timeout is used for waiting for the request to start. When the request is executing, 
        such as retrieving or posting data, the connection is kept alive until the request finishes.
        */
        request.setTimeout(60000);
        HttpResponse response =  http.send(request);
        return response;
    }
    
    //Post Call
    public static HttpResponse  postCall(String endPointURL, String body, String contentType)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Set the key in header.
        request.setHeader('x-api-key', API_KEY);
        //Set the URL to invoke
        request.setEndpoint(endPointURL);            
        request.setHeader('Content-Type', contentType);
        //Sets the type of method to be used for the HTTP request.
        request.setMethod('POST');
        //Sets the contents of the body for this request.
        request.setBody(body);
        /*
        The timeout is the maximum time to wait for establishing the HTTP connection.
        The same timeout is used for waiting for the request to start. When the request is executing, 
        such as retrieving or posting data, the connection is kept alive until the request finishes.
        */
        request.setTimeout(60000); 
        HttpResponse response =  http.send(request);
        return response;
    }
    
    //PUT Call for Blob Body
    public static HttpResponse  putCall(String endPointURL, Blob body, String contentType)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Set the key in header.
        request.setHeader('x-api-key', API_KEY);
        //Set the URL to invoke
        request.setEndpoint(endPointURL);            
        request.setHeader('Content-Type', contentType);
        //Sets the type of method to be used for the HTTP request.
        request.setMethod('PUT');
        //Sets the contents of the body for this request using a Blob.
        request.setBodyAsBlob(body);
        /*
        The timeout is the maximum time to wait for establishing the HTTP connection.
        The same timeout is used for waiting for the request to start. When the request is executing, 
        such as retrieving or posting data, the connection is kept alive until the request finishes.
        */
        request.setTimeout(60000);
        HttpResponse response =  http.send(request);
        return response;
    }
}