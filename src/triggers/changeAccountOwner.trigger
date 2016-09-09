trigger changeAccountOwner on Contact (after insert, after update) {
    List <Id> AccountIds = new List <Id>();
    List <Account> accounts = new List<Account>();
    List <Contact> contacts = new List<Contact>();

    List <Account> accSave = new List<Account>();
    List <Contact> contSave = new List<Contact>();

        for(Contact c:trigger.new ){
        if(c.AccountId !=NULL)
        AccountIds.add(c.AccountId);
        
        }

    accounts = [Select Id, OwnerId From Account Where Id IN :AccountIds];
    contacts = [Select Id, AccountId, OwnerId From Contact Where AccountId IN :AccountIds and Id NOT IN :trigger.new];

        for(Contact c:trigger.new ){
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