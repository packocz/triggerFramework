/**
 * @author Aleš Remta
 * @created 2019-02-08
 */
public virtual class TriggerHandlerBase
    implements ITriggerHandler {

    public virtual void beforeInsertInitBulk(List<sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeInsertInitBulk: Not Implemented');
    }
    public virtual void beforeInsertInit(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeInsertInit: Not Implemented');
    }
    public virtual void beforeUpdateInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeUpdateInitBulk: Not Implemented');
    }
    public virtual void beforeUpdateInit(sObject oldRecord, sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeUpdateInit: Not Implemented');
    }
    public virtual void beforeDeleteInitBulk(Map<Id, sObject> oldRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeDeleteInitBulk: Not Implemented');
    }
    public virtual void beforeDeleteInit(sObject oldRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeDeleteInit: Not Implemented');
    }
    public virtual void beforeUndeleteInitBulk(List<sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeUndeleteInitBulk: Not Implemented');
    }
    public virtual void beforeUndeleteInit(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeUndeleteInit: Not Implemented');
    }

    public virtual void afterInsertInitBulk(Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterInsertInitBulk: Not Implemented');
    }
    public virtual void afterInsertInit(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterInsertInit: Not Implemented');
    }
    public virtual void afterUpdateInitBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterUpdateInitBulk: Not Implemented');
    }
    public virtual void afterUpdateInit(sObject oldRecord, sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterUpdateInit: Not Implemented');
    }
    public virtual void afterDeleteInitBulk(Map<Id, sObject> oldRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterDeleteInitBulk: Not Implemented');
    }
    public virtual void afterDeleteInit(sObject oldRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterDeleteInit: Not Implemented');
    }
    public virtual void afterUndeleteInitBulk(Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterUndeleteInitBulk: Not Implemented');
    }
    public virtual void afterUndeleteInit(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterUndeleteInit: Not Implemented');
    }

    public virtual Boolean shouldDoInit(TriggerFrameworkAction action)
    {
        return true;
    }

    public virtual void onBeforeInsertBulk(List<sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeInsertBulk: Not Implemented');
    }
    public virtual void onBeforeInsert(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeInsert: Not Implemented');
    }
    public virtual void onBeforeUpdateBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeUpdateBulk: Not Implemented');
    }
    public virtual void onBeforeUpdate(sObject oldRecord, sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeUpdate: Not Implemented');
    }
    public virtual void onBeforeDeleteBulk(Map<Id, sObject> oldRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeDeleteBulk: Not Implemented');
    }
    public virtual void onBeforeDelete(sObject oldRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeDelete: Not Implemented');
    }
    public virtual void onBeforeUndeleteBulk(List<sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeUndeleteBulk: Not Implemented');
    }
    public virtual void onBeforeUndelete(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onBeforeUndelete: Not Implemented');
    }

    public virtual void onAfterInsertBulk(Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterInsertBulk: Not Implemented');
    }
    public virtual void onAfterInsert(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterInsert: Not Implemented');
    }
    public virtual void onAfterUpdateBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterUpdateBulk: Not Implemented');
    }
    public virtual void onAfterUpdate(sObject oldRecord, sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterUpdate: Not Implemented');
    }
    public virtual void onAfterDeleteBulk(Map<Id, sObject> oldRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterDeleteBulk: Not Implemented');
    }
    public virtual void onAfterDelete(sObject oldRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterDelete: Not Implemented');
    }
    public virtual void onAfterUndeleteBulk(Map<Id, sObject> newRecords)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterUndeleteBulk: Not Implemented');
    }
    public virtual void onAfterUndelete(sObject newRecord)
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': onAfterUndelete: Not Implemented');
    }

    public virtual Boolean shouldDoAction(TriggerFrameworkAction action)
    {
        return true;
    }

    public virtual void beforeInsertFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeInsertFinally: Not Implemented');
    }
    public virtual void beforeUpdateFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeUpdateFinally: Not Implemented');
    }
    public virtual void beforeDeleteFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeDeleteFinally: Not Implemented');
    }
    public virtual void beforeUndeleteFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': beforeUndeleteFinally: Not Implemented');
    }
    public virtual void afterInsertFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterInsertFinally: Not Implemented');
    }
    public virtual void afterUpdateFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterUpdateFinally: Not Implemented');
    }
    public virtual void afterDeleteFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterDeleteFinally: Not Implemented');
    }
    public virtual void afterUndeleteFinally()
    {   
        String currentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        system.debug(currentClassName + ': afterUndeleteFinally: Not Implemented');
    }

    public virtual Boolean isBlocked()
    {
        return false;
    }
}
