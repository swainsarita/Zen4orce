trigger OpportunityNotification on Opportunity (after insert) {
    Opportunity oppObj =[select ownerid, id,Owner.manager.email,Owner.manager.name from opportunity where id=:trigger.newMap.keySet()];
    for (Opportunity opp : Trigger.new) { 
    
        if(opp.Amount>25000){  
            String userEmail = oppObj.Owner.manager.email; 
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses = new String[] {userEmail}; 
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Automated email: Opps Details'); 
            String body = 'Amount is greater than 25000'; 
            mail.setPlainTextBody(body); 
            Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        } 
    } 
}