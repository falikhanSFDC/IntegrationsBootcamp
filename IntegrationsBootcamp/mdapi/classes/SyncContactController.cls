public class SyncContactController{

    public static Contact getContact(Id contactId){
        Contact c = [Select Id, External_ID__c, firstName, lastName, email from Contact where Id = :contactId];
        return c;
    }
    
    @AuraEnabled
    public static void syncContact(Id contactId){        
        Contact c = getContact(contactId);
        if (c!=null){
            RequestJSON jc = new RequestJSON();
            jc.firstName = c.firstName;
            jc.lastName = c.lastName;
            jc.email = c.email;
            if (String.isBlank(c.External_ID__c)){
                c.External_ID__c = createContact(System.JSON.serialize(jc));
                update c;
            }else{
                updateContact(System.JSON.serialize(jc), c.External_Id__c);
            }
        }       
    }
    public static void updateContact(String contactBody, String contactExtId){
        String newId;
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //request.setEndpoint('http://pern-integration-bootcamp.herokuapp.com/contacts/'+contactExtId);
        request.setEndpoint('callout:heroku_contact_app/contacts/'+contactExtId);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(contactBody);
        request.setMethod('PUT');

        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
        }
    }

    public static String createContact(String contactBody){
        String newId;
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //request.setEndpoint('http://pern-integration-bootcamp.herokuapp.com/contacts');
        request.setEndpoint('callout:heroku_contact_app/contacts');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(contactBody);
        request.setMethod('POST');

        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            ResponseJSON jc = (ResponseJSON) System.JSON.deserialize(response.getBody(), ResponseJSON.class);
            newId = String.valueOf(jc.contact_Id);
        }
        return newId;
    }    

    public class RequestJSON {
        public String firstName;
        public String lastName;
        public String email;
    }
    public class ResponseJSON {
        public Integer contact_id;
        public String firstName;
        public String lastName;
        public String email;
    }
}