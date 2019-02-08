/**
 * Interface defining a trigger handler as part of the TriggerFramework
 */
public Interface ITriggerHandler 
{    
    void beforeInsertInitBulk(List<sObject> newRecords);
    void beforeInsertInit(sObject newRecord);
    void beforeUpdateInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void beforeUpdateInit(sObject oldRecord, sObject newRecord);
    void beforeDeleteInitBulk(Map<Id, sObject> oldRecords);
    void beforeDeleteInit(sObject oldRecord);

    void afterInsertInitBulk(Map<Id, sObject> newRecords);
    void afterInsertInit(sObject newRecord);
    void afterUpdateInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void afterUpdateInit(sObject oldRecord, sObject newRecord);
    void afterDeleteInitBulk(Map<Id, sObject> oldRecords);
    void afterDeleteInit(sObject oldRecord);
    void afterUndeleteInitBulk(Map<Id, sObject> newRecords);
    void afterUndeleteInit(sObject newRecord);

    Boolean shouldDoInit(TriggerFrameworkAction action);

    void onBeforeInsertBulk(List<sObject> newRecords);
    void onBeforeInsert(sObject newRecord);
    void onBeforeUpdateBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void onBeforeUpdate(sObject oldRecord, sObject newRecord);
    void onBeforeDeleteBulk(Map<Id, sObject> oldRecords);
    void onBeforeDelete(sObject oldRecord);

    void onAfterInsertBulk(Map<Id, sObject> newRecords);
    void onAfterInsert(sObject newRecord);
    void onAfterUpdateBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void onAfterUpdate(sObject oldRecord, sObject newRecord);
    void onAfterDeleteBulk(Map<Id, sObject> oldRecords);
    void onAfterDelete(sObject oldRecord);
    void onAfterUndeleteBulk(Map<Id, sObject> newRecords);
    void onAfterUndelete(sObject newRecord);

    Boolean shouldDoAction(TriggerFrameworkAction action);

    void beforeInsertFinally();
    void beforeUpdateFinally();
    void beforeDeleteFinally();
    void afterInsertFinally();
    void afterUpdateFinally();
    void afterDeleteFinally();
    void afterUndeleteFinally();

    Boolean isBlocked();
}
