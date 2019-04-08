/**
 * Interface defining a simpler trigger handler as part of the TriggerFramework
 * @author Aleš Remta
 * @created 2019-02-08
 *
 * All Trigger Contexts are handled separately, if any logic is shared this is handled at the implementation level.
 * There are 3 methods for each context: Init, OnEvent and Finally. The Init and OnEvent can be both Bulk and Individual
 * record based. For that 2 additional methods that can be used to optimise performance by switching OFF some of the
 * methods: shouldDoInit and shouldDoAction.
 *
 * Not intended to be implemented directly, instead TriggerSimpleHandlerBase virtual class should be extended so that only
 * relevant parts of the handler have to be implementated by overriding selected methods. No need to implement every single
 * method defined in this interface that way.
 * 
 */
public Interface ITriggerSimpleHandler {
    void beforeInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void beforeInit(sObject oldRecord, sObject newRecord);
    
    Boolean shouldDoBeforeInitBulk();
    Boolean shouldDoBeforeInit();
    
    void afterInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void afterInit(sObject oldRecord, sObject newRecord);
    
    Boolean shouldDoAfterInitBulk();
    Boolean shouldDoAfterInit();
    
    void onBeforeBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void onBefore(sObject oldRecord, sObject newRecord);

    Boolean shouldDoBeforeActionBulk();
    Boolean shouldDoBeforeAction();
    
    void onAfterBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords);
    void onAfter(sObject oldRecord, sObject newRecord);

    Boolean shouldDoAfterActionBulk();
    Boolean shouldDoAfterAction();
    
    void beforeFinally();
    void afterFinally();

    Boolean isBlocked();
}
