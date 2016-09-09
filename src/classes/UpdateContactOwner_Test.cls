@isTest
private class UpdateContactOwner_Test {

    static testMethod void myUnitTest() {
        Profile p = [select id from profile where name='Standard User'];
 
        User user1 = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US', profileid = p.Id, country='United States',
            timezonesidkey='America/Los_Angeles', username='test1239876@noemail.com');
        insert user1;
        
        User user2 = new User(alias = 'test456', email='test456@noemail.com',
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US', profileid = p.Id, country='United States',
            timezonesidkey='America/Los_Angeles', username='test46545656@noemail.com');
        insert user2;
        
        Account a = new Account(Name = 'Test Account', OwnerId=user1.Id);
        insert(a);
        Contact c1 = new Contact(AccountId=a.Id,lastname='Test1',firstname='Contact', OwnerId=user1.Id);
        insert(c1);
        Contact c2 = new Contact(AccountId=a.Id,lastname='Test2',firstname='Contact', OwnerId=user2.Id);
        insert(c2);
        
         a.OwnerId = user2.Id;        
         update a;
       System.assertEquals(c2.OwnerID , a.OwnerID);
       //System.assertEquals(c1.OwnerID , c1.OwnerID);
        
    }
}