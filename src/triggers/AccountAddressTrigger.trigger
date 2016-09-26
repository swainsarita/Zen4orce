trigger AccountAddressTrigger on Account (before insert, before update) {
    for(Account acc : trigger.new){
        
       // Boolean checkboxValue = acc.Match_Billing_Address__c;
        If (acc.ShippingPostalCode!= null && acc.Match_Billing_Address__c == true )
        {
            acc.BillingPostalCode = acc.ShippingPostalCode;
            
        }
        
        
    }
}