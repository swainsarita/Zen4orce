public with sharing class AccountTriggerHandler {
    public static void onAfterUpdateAccount(List<Account> accountlist, Map<Id, Account> mapAccount) {
    try { 
        Set<Id> accountIds = new Set<Id>(); 
        Map<Id, String> oldOwnerIds = new Map<Id, String>();
        Map<Id, String> newOwnerIds = new Map<Id, String>();
        List<Contact> contactUpdates = new List<Contact>();
       

    for (Account a : accountlist) {
          
            if (a.OwnerId != mapAccount.get(a.Id).OwnerId) {      
            oldOwnerIds.put(a.Id, mapAccount.get(a.Id).OwnerId); 
              System.debug('accountMap@@'+mapAccount.get(a.Id).OwnerId); 
        newOwnerIds.put(a.Id, a.OwnerId); 
        accountIds.add(a.Id); 
            }
        }
        System.debug('accountIds@@'+accountIds);
         
    if ( !accountIds.isEmpty() && accountIds !=null) { 
         for (Account acc : [SELECT Id,
                             (SELECT Id, OwnerId FROM Contacts) 
                             FROM Account WHERE Id in :accountIds]){
            
        String newOwnerId = newOwnerIds.get(acc.Id); 
        String oldOwnerId = oldOwnerIds.get(acc.Id); 
        for (Contact c : acc.Contacts) {
            if (c.OwnerId == oldOwnerId) {
            Contact updatedContact = new Contact(Id = c.Id, OwnerId = newOwnerId);
            contactUpdates.add(updatedContact);
                    }
                }
            }
        }
        update contactUpdates;
    }catch (Exception e) {
        System.debug('The following exception has occurred: ' + e.getMessage());     
          
        }     
    }
}