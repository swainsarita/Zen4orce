@isTest(seeAllData=false)
    private class updateAccountownerTest {

        public static testMethod void testAccount(){
            //Step 1 : Data Insertion
            Account a=new Account(Name='Test Account');
            insert a;
            Contact c = new Contact(Account=a, FirstName='John',LastName='Doe');
            insert c;
            
            test.startTest();
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
      User u1 = new User(Alias = 'standa', Email='saplingstandarduser@testorg.com',
      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
      LocaleSidKey='en_US', ProfileId = p.Id,
      TimeZoneSidKey='America/Los_Angeles', UserName='saplingstandarduser@testorg.com');
            System.runAs(u1) {
      
        Contact c1 = new Contact(FirstName='Jane',LastName='Doe', Account=a);
        insert c1;
         
       
        Contact c2 = [select id, name, Account.id, OwnerId from contact];
                System.debug('c2='+c2);
        //c = [select id, name, Account.Id, OwnerId from contact where id=:c.id];
        a= [select id, ownerId from Account where id=:a.id];
                System.debug('a='+a);
        a.OwnerId=u1.Id;        
        update a;
       System.assertEquals(c1.OwnerID , a.OwnerID);
        
        
        
        test.stopTest();
    }


        }
}