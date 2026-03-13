public with sharing class HttpClient {
    public static HttpResponse send(
        String method,
        String endpoint,
        String body,
        Map<String, String> headers
    ) {

        Http http = new Http();
        HttpRequest request = buildRequest(method, endpoint, body, headers);

        try {
            LoggingService.info('Sending HTTP Request to ' + endpoint);
            
            HttpResponse response = http.send(request);

            handleResponse(response);

            return response;

        } catch (Exception e) {
            LoggingService.error('HTTP callout failed: ' + e.getMessage());
            throw new IntegrationException ('HTTP callout error: ' + e.getMessage());
        }
    }

    private static HttpRequest buildRequest(
        String method,
        String endpoint,
        String body,
        Map<String, String> headers
    ) {
        HttpRequest request = new HttpRequest();

        request.setMethod(method);
        request.setEndpoint(endpoint);
        request.setTimeout(20000);

        if (body != null) {
            request.setBody(body);
        }
        
        if (headers != null) {
            for (String key : headers.keySet()) {
                request.setHeader(key, headers.get(key));
            }
        }
        return request;
        
        }

        private static void handleResponse(HttpResponse response){
            Integer statusCode = response.getStatusCode();

            if (statusCode >= 200 && statusCode < 300) {
                LoggingService.info('HTTP callout successful with status code ' + statusCode);
            } else {
                LoggingService.error(
                    'HTTP callout failed with status code ' + statusCode +
                    ' body ' + response.getBody()
                );
                throw new IntegrationException(
                    'External API error. Status code: ' + statusCode 
                );
            }
        }
}
