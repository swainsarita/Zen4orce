public with sharing class OpportunityHandlerClass {
    
    public static void onAfterInsert(List<Opportunity> opplist , Map<Id, Opportunity> newMap) {

        Map<Id, User> usrMap = new Map<Id, User>([Select Id, ManagerId, Email from User]);
        EmailTemplate etObj =[Select id from EmailTemplate where name=:'Custom Template'];
        List<Messaging.SingleEmailMessage> email = new List<Messaging.SingleEmailMessage>();
       
        for (Opportunity olist : opplist) {
            
            If(olist.Amount > 25000){
                
                If( usrMap.get(olist.OwnerId) != null ){
                Id ManagerId =  usrMap.get(olist.OwnerId).ManagerId;    
                
        String userEmail =usrMap.get(ManagerId).Email;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.setTargetObjectId(ManagerId);
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
}