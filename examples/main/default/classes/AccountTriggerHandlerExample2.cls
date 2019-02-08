public with sharing class AccountTriggerHandlerExample2 
    extends TriggerHandlerBase
{
    private List<Task> revivedAccountsTask = new List<Task>();

    public override Boolean shouldDoInit(TriggerFrameworkAction action) {
        return false;
    }

    public override Boolean shouldDoAction(TriggerFrameworkAction action) {
        return false;
    }

    public override void onAfterUndelete(sObject newRecord) {
        revivedAccountsTask.add(new Task(
            WhatId = newRecord.Id,
            Subject = 'Revived Account',
            Status = 'Completed',
            Priority = 'Normal'));
    }

    public override void afterUndeleteFinally() {
        if(!revivedAccountsTask.isEmpty()) {
            insert revivedAccountsTask;
        }
    }
}
