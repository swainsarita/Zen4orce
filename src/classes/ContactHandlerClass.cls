Public Class ContactHandlerClass{
public static void changeAccountNameOnContact (List<Contact> conList,Map <id,Contact> conOldMap){
        List <Contact> conListToUpdate = new List<Contact>();
        Map<ID,Account> accMap = new Map<Id,Account> ([SELECT ID,OwnerID FROM Account]);
        set<Contact> conId = new set<Contact> ();
        for(Contact con : conList){
            if(con.AccountId != conOldMap.get(con.ID).AccountId ){
                conId.add(con);
            }
        }
        if(conId.size()>0){
            for(Contact cont: conId){
                Account a = accMap.get(cont.AccountId);
                cont.OwnerId = a.OwnerId;
                conListToUpdate.add(cont);
                }
            
        }
        
    }
    public static void changeContactOwnerOnContact (List<Contact> conList){
    List <Id> AccountIds = new List <Id>();
    List <Account> accounts = new List<Account>();
    List <Contact> contacts = new List<Contact>();

    List <Account> accSave = new List<Account>();
    List <Contact> contSave = new List<Contact>();

        for(Contact c:conList ){
        if(c.AccountId !=NULL)
        AccountIds.add(c.AccountId);
        
        }

    accounts = [Select Id, OwnerId From Account Where Id IN :AccountIds];
    contacts = [Select Id, AccountId, OwnerId From Contact Where AccountId IN :AccountIds and Id NOT IN :conList];

        for(Contact c:conList ){
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