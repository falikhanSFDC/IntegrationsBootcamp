public class InitiateFlowFromCDC {

    public void runFlow(String flowName, EventBus.ChangeEventHeader eventData, SObject event)
    {

        // Instantiate the ChangeEventHeader object
        CDCTriggerInput triggerInput = new CDCTriggerInput();

        // Assign the values from the ChangeEventHeader to the TriggerInput
        triggerInput.entityName = eventData.entityName;
        triggerInput.changeType = eventData.changeType;
        triggerInput.commitNumber = eventData.commitNumber;
        triggerInput.commitTimestamp = eventData.commitTimestamp;
        triggerInput.commitUser = eventData.commitUser;
        triggerInput.changeOrigin = eventData.changeOrigin;
        triggerInput.sequenceNumber = eventData.sequenceNumber;
        triggerInput.transactionKey = eventData.transactionKey;
        triggerInput.recordIds = eventData.recordIds;
        triggerInput.changedFields = eventData.changedFields;
        triggerInput.diffFields = eventData.diffFields;
        triggerInput.nulledFields = eventData.nulledFields;           

        //Call out in a future method
        ContactsHelper.syncContact(eventData.recordids[0]);

        //Iterate over the changed fields and add them to the Changed Fields Map   
        for(String fieldName : eventData.changedfields){
            // Some compound fiels like Name and Address include the fully 
            // qualified fieldname so removing that
            if (fieldName.indexOf('.')>0){
                fieldName = fieldName.right(fieldName.length()-fieldName.indexOf('.')-1);
            }
            triggerInput.changedFieldsValues.put(fieldname, event.get(fieldName));
        }


/*      //If we were to initiate a flow

        //Add the Trigger input to the inputs Map
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('TriggerInput', triggerInput);
          
        //Instantiate the Flow and pass in the inputs for use 
        Flow.Interview myFlow = Flow.Interview.createInterview(flowName, inputs);
        myFlow.start();
*/

    }
}