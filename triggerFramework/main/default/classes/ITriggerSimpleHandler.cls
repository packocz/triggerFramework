public Interface ITriggerSimpleHandler {
    void beforeInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void beforeInit(sObject oldRecord, sObject newRecord);
    
    Boolean hasBeforeInitBulk();
    Boolean hasBeforeInit();
    
    void afterInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void afterInit(sObject oldRecord, sObject newRecord);
    
    Boolean hasAfterInitBulk();
    Boolean hasAfterInit();
    
    void onBeforeBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void onBefore(sObject oldRecord, sObject newRecord);
    
    void onAfterBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void onAfter(sObject oldRecord, sObject newRecord);
    
    void beforeFinally();
    void afterFinally();

    Boolean isBlocked();
}
