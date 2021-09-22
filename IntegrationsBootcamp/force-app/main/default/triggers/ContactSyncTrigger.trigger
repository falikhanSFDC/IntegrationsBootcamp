trigger ContactSyncTrigger on Contact_Sync__e (after insert) {

    for (Contact_Sync__e event : Trigger.New)
    {
        ContactsHelper.syncContact(event.Contact_ID__c);
    }
}