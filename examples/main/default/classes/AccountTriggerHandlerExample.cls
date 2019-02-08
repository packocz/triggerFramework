public with sharing class AccountTriggerHandlerExample 
    extends TriggerHandlerBase
{
    private List<Contact> newContacts = new List<Contact>();
    private List<Id> addressChanged = new List<Id>();
    private List<Contact> updateContactAddress;

    public override Boolean shouldDoInit(TriggerFrameworkAction action) {
        switch on action {
            when BEFORE_INSERT,
                 AFTER_INSERT,
                 AFTER_UPDATE {
                return true;
            }
            when else {
                return false;
            }
        }
    }

    public override Boolean shouldDoAction(TriggerFrameworkAction action) 
    {
        switch on action {
            when BEFORE_INSERT,
                 AFTER_INSERT,
                 AFTER_UPDATE_BULK {
                return true;
            }
            when else {
                return false;
            }
        }
    }

    public override void onBeforeInsert(sObject newRecord) {
        Account newAccount = (Account)newRecord;
        if(newAccount.Name.contains('Test')) {
            newAccount.Name.addError('Test accounts not allowed');
        }
    }

    public override void onAfterInsert(sObject newRecord) {
        Account newAccount = (Account)newRecord;
        newContacts.add(new Contact(
            AccountId = newAccount.Id,
            LastName = newAccount.Name));
    }

    public override void afterUpdateInit(sObject oldRecord, sObject newRecord) {
        Account newAccount = (Account)newRecord;
        Account oldAccount = (Account)oldRecord;
        if(oldAccount.BillingCity != newAccount.BillingCity ||
            oldAccount.BillingCountry != newAccount.BillingCountry) {
            addressChanged.add(newAccount.Id);
        }
    }

    public override void onAfterUpdateBulk(Map<Id, sObject> oldRecords, Map<Id, sObject> newRecords) {
        for(Contact c : [SELECT Id, AccountId, MailingCity, MailingCountry
                         FROM Contact
                         WHERE AccountId IN: addressChanged]) {
            Account acc = (Account)newRecords.get(c.AccountId);
            c.MailingCity = acc.BillingCity;
            c.MailingCountry = acc.BillingCountry;
            updateContactAddress.add(c);
        }
    }

    public override void afterInsertFinally() {
        if(!newContacts.isEmpty()) {
            insert newContacts;
        }
    }

    public override void afterUpdateFinally() {
        if(!updateContactAddress.isEmpty()) {
            update updateContactAddress;
        }
    }
}
