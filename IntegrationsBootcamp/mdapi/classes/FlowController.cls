public class FlowController {
   
    @InvocableMethod( label='Sync Contact' description='Sync Contact with External System' category='Callout' )
    public static void syncContact( List < String > inputs ) {

        system.debug( 'Inputs is ' + inputs );
        createContact( inputs.get( 0 ) );
       
    }
   
    @future( callout=true )
    public static void createContact( String triggerInput ) {
        System.debug('triggerInput : '+triggerInput);
        System.debug('starting');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //request.setEndpoint('http://pern-integration-bootcamp.herokuapp.com/todos');
        request.setEndpoint('callout:heroku_contact_app/todos');
        request.setHeader('Content-Type', 'application/json');
        request.setBody('{"description":"testing 321"}');
        request.setMethod('POST');

        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            JSONWrapper todo = (JSONWrapper) System.JSON.deserialize(response.getBody(), JSONWrapper.class);

        }


        // List < String > listInputs = strInput.split( ',' );
        // HTTP h = new HTTP();
        // HTTPRequest req = new HTTPRequest();
        // req.setEndPoint( 'https://jsonplaceholder.typicode.com/todos/' + listInputs.get( 0 ) );
        // req.setMethod('GET');
        // HTTPResponse res = h.send(req); 
        // JSONWrapper wrapper = ( JSONWrapper ) JSON.deSerialize( res.getBody(), JSONWrapper.class );
        // /*
        //    If the response contains multiple values, then you can use the below code
        //    List < JSONWrapper > listWrapper = (List < JSONWrapper >) JSON.deSerialize(res.getBody(), List < JSONWrapper >.class);
        // */
        // Contact objContact = new Contact();
        // objContact.LastName = wrapper.title;
        // objContact.AccountId = listInputs.get( 1 );
        // system.debug( 'Contact is ' + objContact );
        // insert objContact;
       
    }
   
    public class JSONWrapper {
        public Integer todo_id;
        public String description;
    }
   
}