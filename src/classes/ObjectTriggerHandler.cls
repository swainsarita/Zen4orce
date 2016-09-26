public with sharing class ObjectTriggerHandler { 
 /*public static void onBeforeUpdate(List<Lead> leadlist ,Map<Id, Lead> mapLeadOld,Boolean isInsert, Boolean isUpdate) {
        // logics for Update.
try {    
        List<String> leadIds = new List<String>();
        Map<String,Time_Zone__c> areaCodeList = new Map<String,Time_Zone__c>();
        for(Time_Zone__c areaCode : [Select id, 
                                    Name,
                                    New_AreaCode__c,
                                    NewStates__c,
                                    New_TimeZone__c 
                                    from Time_Zone__c])
        {
            areaCodeList.put(areaCode.New_AreaCode__c,areaCode );
        }
        System.debug('leadlist@@'+leadlist);
        for(Lead leadobj:leadlist){
        boolean check = false;
    
             if (isUpdate) {
             if(leadobj.phone != null && leadobj.phone != mapLeadOld.get(leadobj.Id).phone){
                    check = true;
                }
            }
           else{
            check = true;
           }
        String areacodformatted= leadobj.phone.removeStart('(');
        if (check && leadobj.phone != null && areaCodeList.get(areacodformatted.left(3)) != null){ 
                        leadobj.State__c = areaCodeList.get(areacodformatted.left(3)).NewStates__c;
                        leadobj.TimeZone__c = areaCodeList.get(areacodformatted.left(3)).New_TimeZone__c;
        System.debug('statevalue'+leadobj.State__c);
        System.debug('timevalue'+leadobj.TimeZone__c);
               }
        
        }
        
       }catch (Exception e) {
       System.debug('The following exception has occurred: ' + e.getMessage());     
          
            }
        }
       
          
    public static void onAfterUpdateAccount(List<Account> accountlist, Map<Id, Account> mapAccount) {
    try { 
        Set<Id> accountIds = new Set<Id>(); 
        Map<Id, String> oldOwnerIds = new Map<Id, String>();
        Map<Id, String> newOwnerIds = new Map<Id, String>();
        List<Contact> contactUpdates = new List<Contact>();
       

    for (Account a : accountlist) {
          System.debug('accountMap@@'+mapAccount.get(a.Id).OwnerId);
            if (a.OwnerId != mapAccount.get(a.Id).OwnerId) {      
        oldOwnerIds.put(a.Id, mapAccount.get(a.Id).OwnerId); 
               
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
            
    }*/
    public static void changeContactOwner(List<Contact> contactlist, List <Contact> contacts) {
        
        List <Id> AccountIds = new List <Id>();
        List <Account> accounts = new List<Account>();
        //List <Contact> contacts = new List<Contact>();

        List <Account> accSave = new List<Account>();
        List <Contact> contSave = new List<Contact>();
        
            for(Contact c:contactlist ){
            if(c.AccountId !=NULL)
            AccountIds.add(c.AccountId);
            }
            System.debug('AccountIds=='+AccountIds);
        accounts = [Select Id, OwnerId From Account Where Id IN :AccountIds];
        System.debug('accounts=='+accounts);
        contacts = [Select Id, 
                    AccountId, 
                    OwnerId 
                    From Contact Where AccountId IN :AccountIds and Id NOT IN :contactlist];
        
        System.debug('contacts=='+contacts);
        for(Contact c:contactlist ){
            for(Account acc:accounts){
                if(c.AccountId == acc.Id && c.OwnerId !=acc.OwnerId){
                acc.OwnerId = c.OwnerId;
                accSave.add(acc);
                }
            }

        for(Contact con:contacts){
                if(c.AccountId == con.AccountId && c.OwnerId != con.OwnerId){
                con.OwnerId = c.OwnerId;
                contSave.add(con);
                }
            }
        }
        update(accSave);
        update(contSave);
        
    }
}