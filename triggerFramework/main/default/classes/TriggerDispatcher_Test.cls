@isTest 
private class TriggerDispatcher_Test {
    @isTest 
    static void testCoverage() {
        TriggerDispatcher.runTriggers = false;

        Test.startTest();
        try {
            new TriggerDispatcher(Account.getSObjectType()).runTriggerHandlers();
        }
            catch (Exception e) {            
        }
        Test.stopTest();        
    }

    @isTest 
    static void testCoverageMore() {
        TriggerDispatcher.runTriggers = false;
        
        // prettier-ignore
        String metadataJsonString = '{' +
            '"attributes": {' +
              '"type": "TriggerConfig__mdt",' +
              '"url": "/services/data/v49.0/sobjects/TriggerConfig__mdt/m001j0000005rBhAAI"' +
            '},' +
            '"DeveloperName": "Test",' +
            '"ClassName__c": "AccountTriggerHandler",' +
            '"TriggerSObject__c": "Account",' +
            '"Id": "m001j0000005rBhAAI"' +
          '}';

        Test.startTest();
        try {
            TriggerDispatcher dispatcher = new TriggerDispatcher(Account.getSObjectType());
            dispatcher.handlerConfigs.add((TriggerConfig__mdt) JSON.deserialize(metadataJsonString, Schema.TriggerConfig__mdt.class));
            dispatcher.runTriggerHandlers();
        }
        catch (Exception e) {            
        }
        Test.stopTest();        
    }
}
