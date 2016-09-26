@isTest
public class ContactHandlerClassTest {
     static testmethod void accountWithSameOwner(){
        List<Contact> conList = new List <Contact> ();
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u1 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', 
                           LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
                           ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='testuse1@abc.com');
        insert u1;
        User u2 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', 
                           LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
                           ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='testuse2@abc.com');
        insert u2;
        Account acc = new Account (Name = 'Test ACC',OwnerId =u1.Id);
        insert acc;
        Account acc1 = new Account (Name = 'Test ACC',OwnerId =u2.Id);
     insert acc1;
        for(Integer i=0;i<20;i++){
            Contact con = new Contact (LastName = 'Sushant',OwnerID = u1.Id,AccountId = acc.id);
            conList.add(con);
        }
        insert conList;
        
        for(Contact con1 : conList){
            con1.AccountId = acc.Id;
        } 
         update conList;
        List<Contact> conList1 = [Select id,OwnerId,AccountId FROM Contact WHERE id in:conList ];
        for(Contact c1 : conList1)
            system.assertEquals(u1.Id, c1.OwnerId);
    }
     static testmethod void accountWithDifferentOwner(){
        List<Contact> conList = new List <Contact> ();
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u1 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', 
                           LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
                           ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='testuser8@abc.com');
        insert u1;
        User u2 = new User(Alias = 'standt', Email='standarduser@abc.com',EmailEncodingKey='UTF-8', 
                           LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', 
                           ProfileId = p1.Id,TimeZoneSidKey='America/Los_Angeles', UserName='testuser9@abc.com');
        insert u2;
        Account acc = new Account (Name = 'Test ACC',OwnerId =u1.Id);
      insert acc;
        Account acc1 = new Account (Name = 'Test ACC',OwnerId =u2.Id);
        insert acc1;
         Contact con;
        for(Integer i=0;i<20;i++){
            con = new Contact (LastName = 'Sushant',OwnerID = u1.Id,AccountId = acc.id);
            conList.add(con);
        }
        insert conList;
         system.debug('contact list'+conList);
        for(Contact con2 : conList){
            con2.AccountId = acc1.Id;
            system.debug('aid'+con2.AccountId);
        } 
         update conList;
         List<Contact> conList1 = [Select id,OwnerId,AccountId FROM Contact WHERE id =: conList ];
        for(Contact c1 : conList1)
            system.assertEquals(u2.Id, c1.OwnerId);
          
    }
}