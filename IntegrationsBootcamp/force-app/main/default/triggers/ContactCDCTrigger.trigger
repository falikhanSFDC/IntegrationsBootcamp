trigger ContactCDCTrigger on ContactChangeEvent (after insert) {

    InitiateFlowFromCDC flowCaller = new InitiateFlowFromCDC();
    for (ContactChangeEvent event : Trigger.New)
    {
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;        
        flowCaller.runFlow('Contact_CDC_Flow', header, event);    
    }
}