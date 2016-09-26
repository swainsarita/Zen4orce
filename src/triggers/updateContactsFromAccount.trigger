trigger updateContactsFromAccount  on Account (After update) {
    Contact [] conlist =  new Contact [0];
    Account [] acclist =  new Account [0];
    
    For (Account a:Trigger.New){
      if(a.phone != trigger.oldmap.get(a.id).phone ||
       a.fax != trigger.oldmap.get(a.id).fax ||
       a.billingstreet != trigger.oldmap.get(a.id).billingstreet || 
       a.billingcity != trigger.oldmap.get(a.id).billingcity ||
       a.billingstate != trigger.oldmap.get(a.id).billingstate || 
       a.billingpostalcode != trigger.oldmap.get(a.id).billingpostalcode ||
       a.billingcountry != trigger.oldmap.get(a.id).billingcountry) {
      acclist.add(a);
          }

      }
}