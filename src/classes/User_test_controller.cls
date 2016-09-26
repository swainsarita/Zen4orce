public with sharing class User_test_controller {

	//private final Account account;
	//private final User__c use1;
	public List<HR__c> accList{get;set;}
	
	public User__c use1{get;set;}
	public HR__c account{get;set;}
	
	public User_test_controller() {
	    
		account = new HR__c();
		use1 = new User__c();
       use1 =  [Select Id, Name, Email__c,FirstName__c from User__c];
		 system.debug('h@@@@@******@@@r'+use1);
        
        account =  [SELECT Id, Name, Email__c   FROM HR__c
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        system.debug('h@@@@@@@@r'+account);
            }
			
        public  PageReference activateuser(){
           
			//use1.IsActive = TRUE;
			use1.Email__c = account.Email__c;
			use1.Name = account.Name;
			use1.FirstName__c = account.Name;
			//insert u1;
			
			account.All_Active_USer__c = use1.id;
			system.debug('hr'+account.All_Active_USer__c);
			update account;
			return (new ApexPages.StandardController(account)).view();
        }
		
		public PageReference save() {
        try {
		    insert use1;
            upsert(account);
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        PageReference redirectSuccess = new ApexPages.StandardController(Account).view();
        return (redirectSuccess);
            }
        }