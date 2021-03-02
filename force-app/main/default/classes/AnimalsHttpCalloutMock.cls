@IsTest
global inherited sharing class AnimalsHttpCalloutMock implements HttpCalloutMock {

    public String externalId {set; get;}
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        if (request.getEndpoint().endsWith('/animals')) {
            response.setBody('{"animals": ["fluffy bunny", "chicken"]}');
        } else if (request.getEndpoint().endsWith('/animals/' + externalId)) {
            response.setBody('{"animal":{"id":"' + externalId + '","name":"chicken","eats":"chicken food","says":"cluck cluck"}}');
        } else {
            response.setBody('{}');
        }
        return response;
    }
}