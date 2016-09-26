public with sharing class LeadTriggerHandler {
    public static void TimezoneUpdateOnLead(List<Lead> leadlist ,Map<Id, Lead> mapLeadOld,Boolean isInsert, Boolean isUpdate) {
        // logics for Update.
try {    
        List<String> leadIds = new List<String>();
        Map<String,Time_Zone__c> areaCodeList = new Map<String,Time_Zone__c>();
        for(Time_Zone__c areaCode : [Select id, 
                                    Name,
                                    New_AreaCode__c,
                                    NewStates__c,
                                    New_TimeZone__c 
                                    from Time_Zone__c])
        {
            areaCodeList.put(areaCode.New_AreaCode__c,areaCode );
        }
        System.debug('leadlist@@'+leadlist);
        for(Lead leadobj:leadlist){
        boolean check = false;
    
             if (isUpdate) {
             if(leadobj.phone != null && leadobj.phone != mapLeadOld.get(leadobj.Id).phone){
                    check = true;
                }
            }
           else{
            check = true;
           }
        String areacodformatted= leadobj.phone.removeStart('(');
        if (check && leadobj.phone != null && areaCodeList.get(areacodformatted.left(3)) != null){ 
                        leadobj.State__c = areaCodeList.get(areacodformatted.left(3)).NewStates__c;
                        leadobj.TimeZone__c = areaCodeList.get(areacodformatted.left(3)).New_TimeZone__c;
        System.debug('statevalue'+leadobj.State__c);
        System.debug('timevalue'+leadobj.TimeZone__c);
               }
        
        }
        
       }catch (Exception e) {
       System.debug('The following exception has occurred: ' + e.getMessage());     
          
            }
        }
       
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
    public static void CloneLead(List<Lead> leadlist ) {
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
}
    
   /* public static void CloneLead(List<Lead> leadlist ) {
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
       */ 
  
    public static void leadDuplicatePreventer(List<Lead> leadlist ,Map<Id, Lead> mapLeadOld,Boolean isInsert, Boolean isUpdate ) {
        try{
        List<String> phones = new List<String>();
	    List<String> emails = new List<String>();
	    for(Lead leadobj: leadlist){
		
		    if(leadobj.Phone!=null)
			phones.add(leadobj.Phone);
		   
		    if(leadobj.email!=null)
			emails.add(leadobj.email);
         
        }
		Lead[] leads = [select id, 
                                Phone, 
                                email 
                                from lead where Phone IN :phones OR email IN :emails];
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
           boolean  check = false;
            
           if (isUpdate) {
                if( leadobj.phone != mapLeadOld.get(leadobj.Id).phone  || leadobj.email != mapLeadOld.get(leadobj.Id).email){
                    check = true;
                    System.debug('@@@@@'+leadobj.phone != mapLeadOld.get(leadobj.Id).phone );
              }
           }
            else{
                check = true;
            }
        
            if(check && (leadMapEmail.containsKey(leadobj.email) || leadMapPhone.containsKey(leadobj.phone))){
                leadobj.addError('Duplicate Lead Found with  phone and Email');
                }
            }
        }catch (Exception e) {
       System.debug('The following exception has occurred: ' + e.getMessage());     
          
            }
        }	
    }