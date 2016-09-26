trigger CloneLead on Lead (before insert , before update) {
    
    
    List <Lead> listLead = new  List<Lead>();
    for(Lead lead :trigger.new){
       if( lead.Status != null && lead.Status == 'Open - Not Contacted'){
           Lead leadNew = new Lead ();
           //leadNew.Name = lead.name;
           leadNew.LastName = lead.LastName;
           leadNew.FirstName = lead.FirstName;
           leadNew.Company = 'Zen4orce';
           leadNew.Status= 'Working - Contacted';
           leadNew.LeadSource = 'Web'; 
           leadNew.MobilePhone = '3434567890';
           
           listLead.add(leadNew);
           //insert listLead;
           System.debug('@@@@@@'+listLead);
            }
       }
    if(!listLead.IsEmpty())
        insert listLead;
    
}