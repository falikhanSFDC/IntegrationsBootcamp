trigger ContactTrigger on Contact (after insert, after update, after delete) {
         
     for(Contact c : Trigger.New){
        // Create an instance of the event and store it in the contactSyncEvent variable
        Contact_Sync__e contactSyncEvent = new Contact_Sync__e(
                   Contact_Id__c=c.Id);
        
        // Call method to publish events
        Database.SaveResult sr = EventBus.publish(contactSyncEvent);
        
        // Inspect publishing result
        if (sr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' +
                             err.getStatusCode() +
                             ' - ' +
                             err.getMessage());
            }
        }
    }
    
}