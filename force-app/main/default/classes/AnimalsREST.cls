@RestResource(urlMapping='/Animals/*')
global class AnimalsREST {
    
	@HttpGet
    global static void getAnimal() {
        RestRequest request = RestContext.request;
        try {
            String externalId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
            List<Animal__c> animals = [SELECT Id, Name, Says__c, Eats__c, ExternalId__c FROM Animal__c WHERE ExternalId__c =: externalId];
            String animalJson = '';
            if (!animals.isEmpty()) {
                animalJson = JSON.serialize(animals.get(0));
            } else {
                animalJson =  JSON.serialize(AnimalsUtils.createExternalAnimal(externalId));
            }
            RestContext.response.statusCode = 200;
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(animalJson);    
            Log.success(animalJson);
        } catch (Exception e) {
            Log.error(e.getMessage());
        }   
    }
}