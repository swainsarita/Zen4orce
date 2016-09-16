public with sharing class OpportunityHandlerClass {
    
    public static void onAfterInsert(List<Opportunity> opplist , Map<Id, Opportunity> newMap) {
        
      // List<Opportunity> opp =[select ownerid, id,Owner.manager.email,Owner.manager.name, Amount from opportunity where Amount > 25000 ];
       // System.debug('@@@@@@@'+opplist);
      
        EmailTemplate etObj =[Select id from EmailTemplate where name=:'Custom Template'];
        List<Messaging.SingleEmailMessage> email = new List<Messaging.SingleEmailMessage>();
       
        for (Opportunity olist : opplist) 
    { 
        If(olist.Amount > 25000){
             id userid=olist.ownerid;
             User myUser = [select id, email from user where id =:userid]; 
             id managerid = myUser.id;
        System.debug('@@@@@@@'+myUser);
            
        String userEmail = myUser.email; 
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.setTargetObjectId(managerid);
        mail.setTemplateID(etObj.Id);
        mail.setSaveAsActivity(false);
        String[] toAddresses = new String[] {userEmail}; 
            mail.setToAddresses(toAddresses); 
        email.add(mail);
        system.debug('olist'+email);
    Messaging.sendEmail(email);
              } 
           }
        }
    }