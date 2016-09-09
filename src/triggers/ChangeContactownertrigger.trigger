trigger ChangeContactownertrigger on Account (after update) {
  
      Set<Id> accountIds = new Set<Id>(); 
      Map<Id, String> oldOwnerIds = new Map<Id, String>();
      Map<Id, String> newOwnerIds = new Map<Id, String>();
      List<Contact> contactUpdates = new List<Contact>(); 
     
      for (Account a : Trigger.new) 
      { 
         if (a.OwnerId != Trigger.oldMap.get(a.Id).OwnerId) 
             System.debug('IDOwner'+a.OwnerId);
             System.debug('IDVALUE'+Trigger.oldMap.get(a.Id).OwnerId);
             
         {
            oldOwnerIds.put(a.Id, Trigger.oldMap.get(a.Id).OwnerId); 
            System.debug('ID_New'+a.Id);
            System.debug('ID@@@@'+oldOwnerIds);
             
            newOwnerIds.put(a.Id, a.OwnerId); 
            System.debug('ID@@@@***'+newOwnerIds);
            accountIds.add(a.Id); 
            System.debug('I am here'+accountIds);
         }
      }
        if ( !accountIds.isEmpty() && accountIds !=null) { 
         for (Account acc : [SELECT Id, (SELECT Id, OwnerId FROM Contacts) FROM Account WHERE Id in :accountIds])
            {
            String newOwnerId = newOwnerIds.get(acc.Id); 
            System.debug('ID_Here'+newOwnerId);
            String oldOwnerId = oldOwnerIds.get(acc.Id); 
            System.debug('--ID--'+oldOwnerId);
            for (Contact c : acc.Contacts) 
            { 
               if (c.OwnerId == oldOwnerId) 
                System.debug('contactOwner'+c.OwnerId);   
               {
               Contact updatedContact = new Contact(Id = c.Id, OwnerId = newOwnerId);
               System.debug('--updatedContact--'+updatedContact);
               contactUpdates.add(updatedContact);
               System.debug('contactUpdates'+contactUpdates);
               }
            }
            
            }
       }
            update contactUpdates;
}