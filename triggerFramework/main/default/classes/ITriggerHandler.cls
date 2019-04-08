/**
 * Interface defining a trigger handler as part of the TriggerFramework
 * @author Aleš Remta
 * @created 2019-02-08
 *
 * All Trigger Contexts are handled separately, if any logic is shared this is handled at the implementation level.
 * There are 3 methods for each context: Init, OnEvent and Finally. The Init and OnEvent can be both Bulk and Individual
 * record based. For that 2 additional methods that can be used to optimise performance by switching OFF some of the
 * methods: shouldDoInit and shouldDoAction.
 *
 * Not intended to be implemented directly, instead TriggerHandlerBase virtual class should be extended so that only
 * relevant parts of the handler have to be implementated by overriding selected methods. No need to implement every single
 * method defined in this interface that way.
 * 
 */
public Interface ITriggerHandler {    
    /**
     * beforeInsertInitBulk should contain any pre-logic and initialisations required to perform the work
     * intended to be achieved by the handler. Used when there is no need to consider earch record separately,
     * but reather the full list. Should not iterate over the list.
     *
     * @param  newRecords trigger.new list of records
     */
    void beforeInsertInitBulk(List<sObject> newRecords);
    /**
     * beforeInsertInit should contain any pre-logic and initialisations required to perform the work
     * intended to be achieved by the handler. Framework will call this method for each of the trigger.new
     * records. Can be used to collect Ids or relevant records and so on.
     *
     * @param  newRecord one of the trigger.new records
     */
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

    /**
     * shouldDoInit tells the framework whether to call the init method for a specified TRIGGER CONTEXT. Used
     * to optimise performance so specifically meant to disable the per-record init methods if not required so
     * as not to iterate over the trigger records if it's not required.
     *
     * @param  action the trigger context in question, e.g. BEFORE_INSERT, BEFORE_INSERT_BULK, ...
     * @return        return description
     */
    Boolean shouldDoInit(TriggerFrameworkAction action);

    /**
     * onBeforeInsertBulk should contain the the trigger/handler logic - the actual work. Should not perform 
     * DML operations.
     *
     * @param  newRecords trigger.new list of records
     */
    void onBeforeInsertBulk(List<sObject> newRecords);
    /**
     * onBeforeInsert should contain the the trigger/handler logic to be applied to each record. Should not perform 
     * DML operations. Record passed by reference, changing properties will affect records in DB
     *
     * @param  newRecords record from trigger.new list of records
     */
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

    /**
     * shouldDoAction tells the framework whether to call the action method for a specified TRIGGER CONTEXT. Used
     * to optimise performance so specifically meant to to be used to disabl either the per-record action or 
     * full list action so that only one would be used.
     *
     * @param  action action description
     * @return        return description
     */
    Boolean shouldDoAction(TriggerFrameworkAction action);

    /**
     * beforeInsertFinally Should contain any cleanup or DML operations. Always called by the fremework in this
     * context, regardless if bulk or single record init and action methods were used.
     */
    void beforeInsertFinally();
    void beforeUpdateFinally();
    void beforeDeleteFinally();
    void afterInsertFinally();
    void afterUpdateFinally();
    void afterDeleteFinally();
    void afterUndeleteFinally();

    Boolean isBlocked();
}
