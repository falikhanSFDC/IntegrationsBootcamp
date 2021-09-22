public class ContactsHelper {
    @future (callout=true)
    public static void syncContact(String contactId) {
        System.debug('@@@ : contactId : '+ contactId);
        SyncContactController.syncContact(contactId);        
    }
}
