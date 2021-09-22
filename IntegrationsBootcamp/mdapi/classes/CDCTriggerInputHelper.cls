/* FieldType, this will return the type of the field and can help you determine with of the other output parameters you may want to use. Possible values are: BOOLEAN, DATE, DATETIME, INTEGER, DOUBLE, LONG or STRING. FieldType is a String parameter.
* FieldValueString, if your FieldType is STRING then this parameter will hold the actual value and this parameter is of type String. This one is special, because one thing the helper class does is to make every type of field value as a string available in this output parameter. 
* FieldValueInteger, this is an output type INTEGER, in flow we’ll use a Number variable for this.
* FieldValueDouble, this is an output type DOUBLE, in flow we’ll use a Number variable for this.
* FieldValueLong, as you guess by now is linked to LONG and is again a Number variable.
* FieldValueDate, is a DATE type and linked to Date variables.
* FieldValueDatetime, is a DATETIME type and linked to Date/Time variables
* FieldValueBoolean, is the BOOLEAN type and can be stored in a Boolean variable.
*/


global class CDCTriggerInputHelper {

    @InvocableMethod(label='Get Trigger Changed Field Value' description='Get the value for a changed field')
    global static List<CDCTriggerInputHelperResult> getTriggerChangedFieldValue(List<CDCTriggerInputHelperRequest> requests) {
        
        List<CDCTriggerInputHelperResult> returnValue = new List<CDCTriggerInputHelperResult>();
        
        for (CDCTriggerInputHelperRequest request : requests)
        {
            CDCTriggerInputHelperResult result = new CDCTriggerInputHelperResult();
               
            Schema.DescribeFieldResult dfr = Schema.describeSObjects(new String[]{request.triggerContext.entityName})[0].fields.getMap().get(request.fieldName).getDescribe(); 
            
            result.fieldType = dfr.getType().name();
            Object changedValue = request.triggerContext.changedFieldsValues.get(request.fieldName);

            switch on dfr.getType() {
                when Boolean {
                    result.fieldValueBoolean = (Boolean) changedValue;
                }
                when Date {
                    result.fieldValueDate = (Date) changedValue;
                    result.fieldValueString = String.valueOfGmt((Date) changedValue);
                }
                when DateTime {
                    result.fieldValueDateTime = (DateTime) changedValue;
                    result.fieldValueString = String.valueOfGmt((DateTime) changedValue);
                }
                when Double, Currency {
                    result.fieldValueDouble = (Double) changedValue;
                    result.fieldType = Schema.DisplayType.Double.name();
                }
                when Integer {
                    result.fieldValueInteger = (Integer) changedValue;
                }
                when Long {
                    result.fieldValueLong = (Long) changedValue;
                }
                when Else {
                    result.fieldValueString = (String) changedValue;
                    result.fieldType = Schema.DisplayType.String.name();
                }  
            }
            returnValue.add(result);
        }
        return returnValue;
    }
    
    global class CDCTriggerInputHelperRequest {
        @InvocableVariable
        global CDCTriggerInput triggerContext;
        
        @InvocableVariable
        global String fieldName;
    }
    
    global class CDCTriggerInputHelperResult {
            
        @InvocableVariable
        global String fieldType;
        
        @InvocableVariable
        global String fieldValueString;
        
        @InvocableVariable
        global Integer fieldValueInteger;
        
        @InvocableVariable
        global Double fieldValueDouble;
        
        @InvocableVariable
        global Long fieldValueLong;
        
        @InvocableVariable
        global Date fieldValueDate;
        
        @InvocableVariable
        global Datetime fieldValueDatetime;
            
        @InvocableVariable
        global Boolean fieldValueBoolean;
    }
}
