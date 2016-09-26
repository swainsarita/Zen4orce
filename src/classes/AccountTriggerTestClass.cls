@isTest
public class AccountTriggerTestClass {
    static testmethod void SameOwner(){
        
        List<Account> accList = new List <Account> ();
        
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u1 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@abc.com');
        insert u1;
        User u2 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser2@abc.com');
        insert u2;
        Account acc;
        
        for(Integer i=0;i<50;i++){
           acc = new Account (Name = 'Test Account',OwnerId=u1.Id);
            accList.add(acc);
            }
       insert accList;
            
        List<Contact> conList = new List <Contact> ();
        for(Integer i =0;i<50;i++){
            Contact con = new Contact (LastName = 'Testing',OwnerId =u1.id,AccountId = acc.Id);
            system.debug('account id'+acc.Id);
                conList.add(con);
        }
       insert conList;
        
            
        for(Account acc1 : accList){
            acc1.OwnerId = u1.id;
        } update accList;
        List<Contact> contact = [Select id,OwnerID from Contact where AccountId in:accList];
        for(Contact c1 : contact)
        system.assertEquals(u1.id, c1.OwnerId);
        }
    
    static testmethod void UpdateOwner(){
        List<Account> accList = new List <Account> ();
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u1 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser3@abc.com');
        insert u1;
        User u2 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser4@abc.com');
        insert u2;
        Account acc;
        Contact con;
        // Account acc1;
        for(Integer i=0;i<50;i++){
           acc = new Account (Name = 'Test Account',OwnerId=u1.Id);
            accList.add(acc);
            }
        insert accList;
        List<Contact> conList = new List <Contact> ();
        for(Integer i =0;i<50;i++){
            con = new Contact (LastName = 'Testing',OwnerId =u1.id,AccountId = acc.Id);
                conList.add(con);
        }
        System.debug('conList'+conList);
       insert conList;
        for(Account acc1 : accList){
            acc1.OwnerId = u2.id;
        } update accList;
        List<Contact> contact = [Select id,OwnerID from Contact where AccountId in:accList];
        for(Contact c1 : contact)
        system.assertEquals(u2.id, c1.OwnerId);
        
    }
   
}