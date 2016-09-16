public with sharing class LeadTriggerHandler {
    
    public static void onAfterInsert(List<Lead> leadlist ) {
         System.debug(' inside onAfterInsert');
         List<Task> lTask = new List<Task> ();
         Task t;
         
              
          for(Lead leadobj:leadlist){
              if((leadobj.LeadSource != null)&&(leadobj.LeadSource == 'Web')){
                  System.debug(' inside onAfterInsert if');
                 t = new Task(); 
                 t.OwnerId = leadobj.OwnerId;
                 t.WhoId = leadobj.id;
                 t.Subject = 'Lead Web Comment';
                 t.Priority = 'Normal';
                 t.Status = 'Not Started';
                 t.Description = leadobj.Description;
                 lTask.add(t);
              System.debug('lTask@@@'+lTask);
                  }
              }
                if(!lTask.IsEmpty())
          		insert lTask;
                 
     }
    /*public static void CloneLead(List<Lead> leadlist ) {
			List <Lead> listLead = new  List<Lead>();
		for(Lead lead :leadlist){
		   if( lead.Status != null && lead.Status == 'Open - Not Contacted'){
			  Lead clonedAcc = lead.clone(false, true, false, false);
			   clonedAcc.Status= 'Working - Contacted';
			   listLead.add(clonedAcc);
			   System.debug('@@@@@@'+listLead);
				}
		   }
		if(listLead!= null && !listLead.IsEmpty())
			insert listLead;
}*/
    
    public static void CloneLead(List<Lead> leadlist ) {
			List <Lead> listLead = new  List<Lead>();
		for(Lead lead :leadlist){
		   if( lead.Status != null && lead.Status == 'Open - Not Contacted'){
			  Lead clonedAcc = new Lead();    //lead.clone(false, true, false, false);
               clonedAcc.FirstName = lead.FirstName;
               clonedAcc.LastName = lead.LastName;
               clonedAcc.Company = 'Zen4orce';
               clonedAcc.LeadSource = 'web'; 
			   clonedAcc.Status= 'Working - Contacted';
			   listLead.add(clonedAcc);
			   System.debug('@@@@@@'+listLead);
				}
		   }
		if(listLead!= null && !listLead.IsEmpty())
			insert listLead;
    }
        
   public static void leadDuplicatePreventer(List<Lead> leadlist ) {
        List<String> phones = new List<String>();
	    List<String> emails = new List<String>();
	    for(Lead leadobj: leadlist){
		
		    if(leadobj.Phone!=null)
			phones.add(leadobj.Phone);
		   
		    if(leadobj.email!=null)
			emails.add(leadobj.email);
         
        }
		Lead[] leads = [select id, Phone, email from lead where Phone IN :phones OR email IN :emails];
		map<string, lead> leadMapEmail = new map<string, lead>();
        map<string, lead> leadMapPhone = new map<string, lead>();
		
		for(Lead leadobj : leads){
            if(string.isNotEmpty(leadobj.email)){
                leadMapEmail.put(leadobj.email, leadobj);
            }
            if(string.isNotEmpty(leadobj.phone)){
                leadMapPhone.put(leadobj.phone, leadobj);
            }
        }

        for(Lead leadobj : leadlist){
            if(leadMapEmail.containsKey(leadobj.email) || leadMapPhone.containsKey(leadobj.phone)){
                leadobj.addError('Duplicate Lead Found with  phone and Email');
            }
        }
		
    }
}