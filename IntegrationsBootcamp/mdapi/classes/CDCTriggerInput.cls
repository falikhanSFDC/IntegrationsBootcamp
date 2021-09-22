public class CDCTriggerInput {

    public CDCTriggerInput()
    {
        this.changedFieldsValues = new Map<String, Object>();
    }
    
    @AuraEnabled public String entityName;
    @AuraEnabled public String changeType;
    @AuraEnabled public Long commitNumber;
    @AuraEnabled public Long commitTimeStamp;
    @AuraEnabled public String commitUser;
    @AuraEnabled public String changeOrigin;
    @AuraEnabled public Integer sequenceNumber;
    @AuraEnabled public String transactionKey;
    @AuraEnabled public List<String> recordIds;
    @AuraEnabled public List<String> changedFields;
    @AuraEnabled public Map<String, Object> changedFieldsValues;
    @AuraEnabled public List<String> diffFields;
    @AuraEnabled public List<String> nulledFields;
}