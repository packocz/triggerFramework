@IsTest 
private class AccountTriggerHandlerExample_Test {
    
    @IsTest
    static void testTriggerExampleInsertPass() {
        List<Account> accs = new List<Account>();
        accs.add(new Account(Name = 'My Account 1'));
        accs.add(new Account(Name = 'My Account 2'));
        accs.add(new Account(Name = 'My Account 3'));

        Test.startTest();

        insert accs;

        Test.stopTest();

        List<Contact> cons = [
                SELECT Id, LastName, AccountId
                FROM Contact
                WHERE AccountId in: accs
                ORDER BY Account.Name
        ];

        System.assertEquals(3, cons.size(), 'Incorrect number of Contacts created');
        for(Integer i = 0; i < cons.size(); i++) {
            System.assertEquals('My Account ' + (i+1), cons[i].LastName, 'Incorrect Last Name copied from Account');
            System.assertEquals(accs[i].Id, cons[i].AccountId, 'Incorrect AccountId assigned'); 
        }
    }
}
