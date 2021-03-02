@IsTest
public inherited sharing class AnimalsRESTTest {
    

    @IsTest
    static void getAnimalFromRequestTest() {
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        String externalId = '1';
        AnimalsHttpCalloutMock httpMock = new AnimalsHttpCalloutMock();

        httpMock.externalId = externalId;
        Test.setMock(HttpCalloutMock.class, httpMock);
        request.requestUri = 'https://test-animals-developer-edition.eu40.force.com/services/apexrest/Animals/'+ externalId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = res;
        AnimalsREST.getAnimal();
        System.assertEquals(200, res.statusCode);
        System.assertEquals(true, res.headers.containsKey('Content-Type'));
        System.assertEquals('application/json', res.headers.get('Content-Type'));
        System.assert(res.responseBody.size() > 0);        
        CustomLog__c log = [SELECT Id, Type__c FROM CustomLog__c LIMIT 1];
        System.assertEquals('SUCCESS', log.Type__c);
    }

    @IsTest
    static void getAnimalFromDBTest() {
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        String externalId = '1';
        Animal__c animal = new Animal__c(ExternalId__c = externalId, Name = 'Name Test', Says__c = 'Says Test', Eats__c = 'Eats Test');
        insert animal;

        request.requestUri = 'https://test-animals-developer-edition.eu40.force.com/services/apexrest/Animals/'+ externalId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = res;
        AnimalsREST.getAnimal();
        System.assertEquals(200, res.statusCode);
        System.assertEquals(true, res.headers.containsKey('Content-Type'));
        System.assertEquals('application/json', res.headers.get('Content-Type'));
        System.assert(res.responseBody.size() > 0);
        CustomLog__c log = [SELECT Id, Type__c FROM CustomLog__c LIMIT 1];
        System.assertEquals('SUCCESS', log.Type__c);
    }
    
    @IsTest
    static void getAnimalErrorTest() {
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        String externalId = '1';
        AnimalsHttpCalloutMock httpMock = new AnimalsHttpCalloutMock();

        httpMock.externalId = null;
        Test.setMock(HttpCalloutMock.class, httpMock);
        request.requestUri = 'https://test-animals-developer-edition.eu40.force.com/services/apexrest/Animals/'+ externalId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = res;
        AnimalsREST.getAnimal();
        CustomLog__c log = [SELECT Id, Type__c FROM CustomLog__c LIMIT 1];
        System.assertEquals('ERROR', log.Type__c);
    }
}
