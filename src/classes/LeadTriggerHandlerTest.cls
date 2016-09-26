@isTest(seeAllData=false)
    private class LeadTriggerHandlerTest {
        public static testMethod void TimezoneUpdateTest(){
            Map<String,Time_Zone__c> areaCodeList = new Map<String,Time_Zone__c>();
            List <Time_Zone__c> timezonelist = new List<Time_Zone__c>(); 
            List <Lead> leadlist =  new List <Lead>();
            
            //INSERTING RECORDS
            Time_Zone__c timevalue1 = new Time_Zone__c  (Name ='test1',New_AreaCode__c='515',NewStates__c='Orissa',New_TimeZone__c='T4');
            timezonelist.add(timevalue1);
            Time_Zone__c timevalue2 = new Time_Zone__c  (Name ='test2',New_AreaCode__c='616',NewStates__c='Bihar',New_TimeZone__c='T3');
            timezonelist.add(timevalue2);
            Time_Zone__c timevalue3 = new Time_Zone__c  (Name ='test3',New_AreaCode__c='717',NewStates__c='Karnataka',New_TimeZone__c='T2');
            timezonelist.add(timevalue3);
            Time_Zone__c timevalue4 = new Time_Zone__c  (Name ='test4',New_AreaCode__c='818',NewStates__c='Maharasthra',New_TimeZone__c='T1');
            timezonelist.add(timevalue4);
            insert timezonelist;
            
            Lead leadobj1 = new Lead(FirstName='Trigger1', LastName='Test1', Company='Trigger Test1', Status='New1',State__c='',TimeZone__c='',Phone= '5154323454');
            leadlist.add(leadobj1);
            Lead leadobj2 = new Lead(FirstName='Trigger2', LastName='Test2', Company='Trigger Test2', Status='New2',State__c='',TimeZone__c='',Phone= '6164323454');
            leadlist.add(leadobj2);
            Lead leadobj3 = new Lead(FirstName='Trigger3', LastName='Test3', Company='Trigger Test3', Status='New3',State__c='',TimeZone__c='',Phone= '7174323454');
            leadlist.add(leadobj3);
            Lead leadobj4 = new Lead(FirstName='Trigger4', LastName='Test4', Company='Trigger Test4', Status='New4',State__c='',TimeZone__c='',Phone= '8184323454');
            leadlist.add(leadobj4);
           
            insert leadlist;
            System.debug('leadlist'+leadlist);
            
            List<Lead> lLeads = [Select id,  FirstName, LastName, Company, Status, Area_Code__c, State__c,TimeZone__c,Phone from Lead where Id=:leadlist ];
            List<Time_Zone__c>  tZone = [Select Id,Name,New_AreaCode__c,NewStates__c,New_TimeZone__c from Time_Zone__c where Id=: timezonelist ];
         
            for(Time_Zone__c areaCode :tZone){
            areaCodeList.put(areaCode.New_AreaCode__c,areaCode);
            }
            for(lead newlead : lLeads){
            String areacodformatted = (newlead.phone != null ? newlead.phone.removeStart('(') : '');
                       if(newlead.phone != null && areaCodeList.get(areacodformatted.left(3)) != null ){
                        System.assertEquals(newlead.State__c, areaCodeList.get(areacodformatted.left(3)).NewStates__c);
						System.assertEquals(newlead.TimeZone__c, areaCodeList.get(areacodformatted.left(3)).New_TimeZone__c);
                        }
                    }
               }
        public static testMethod void TimezoneUpdateTestNew(){
            Map<String,Time_Zone__c> areaCodeList = new Map<String,Time_Zone__c>();
            List <Time_Zone__c> timezonelist = new List<Time_Zone__c>(); 
            List <Lead> leadlist =  new List <Lead>();
            for(Integer i=0;i<50;i++){
                Time_Zone__c timevalue1 = new Time_Zone__c  (Name ='test1',New_AreaCode__c='515',NewStates__c='Orissa',New_TimeZone__c='T4');
                timezonelist.add(timevalue1);
                Time_Zone__c timevalue4 = new Time_Zone__c  (Name ='test4',New_AreaCode__c='818',NewStates__c='Maharasthra',New_TimeZone__c='T1');
                timezonelist.add(timevalue4);
            }
            Database.SaveResult[] srList = Database.insert(timezonelist, false);
            for (Database.SaveResult sr : srList) {
		if (sr.isSuccess()) {
			}else {
			for(Database.Error err : sr.getErrors()) {
           
                }
            }
        }  
		Lead leadobj4;
			for(Integer i=0;i<50;i++){
				leadobj4 = new Lead(FirstName='Trigger4', LastName='Test4', Company='Trigger Test4', Status='New4',State__c='',TimeZone__c='',Phone= '8184323454');
				leadlist.add(leadobj4);
			}
        Insert leadlist;
          
            List<Lead> lLeads = [Select id,  FirstName, LastName, Company, Status, Area_Code__c, State__c,TimeZone__c,Phone from Lead where Id=:leadlist ];
            List<Time_Zone__c>  tZone = [Select Id,Name,New_AreaCode__c,NewStates__c,New_TimeZone__c from Time_Zone__c where Id=: timezonelist ];
        for(Lead leadObj :lLeads){
                leadObj.Phone= '5154323454';
            }
         update lLeads;
             List<Lead> lLeads1 = [Select id,  FirstName, LastName, Company, Status, Area_Code__c, State__c,TimeZone__c,Phone from Lead where Id=:lLeads ];
            System.debug('HELLOOOOOO'+lLeads);
            for(Time_Zone__c areaCode :tZone){
            areaCodeList.put(areaCode.New_AreaCode__c,areaCode);
            }
            for(lead newlead : lLeads1){
            String areacodformatted = (newlead.phone != null ? newlead.phone.removeStart('(') : '');
                       if(newlead.phone != null && areaCodeList.get(areacodformatted.left(3)) != null ){
                            System.assertEquals(newlead.State__c, areaCodeList.get(areacodformatted.left(3)).NewStates__c);
                            System.assertEquals(newlead.TimeZone__c, areaCodeList.get(areacodformatted.left(3)).New_TimeZone__c);
                               
                        }
                    }
        }
      
        public static testMethod void onAfterInsert(){
            List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',LeadSource = 'Web');
            leadList.add(l1);
        }
            insert leadList;
		    List<Task> tsk = [SELECT id,Subject,WhoId FROM Task WHERE WhoId =:leadList];
		for(Task t:tsk)
        {system.assertEquals(t.Subject, 'Lead Web Comment');}
           system.assertEquals(leadList.size(),tsk.size()); 
        }
        
        
    public static testMethod void leadDuplicatePreventer(){
            Lead lead1 = new Lead(LastName='Test1', Company='Test1 Inc.',
                           Phone= '9876787653', Email='test1@duptest.com');
            Lead lead2 = new Lead(LastName='Test2', Company='Test2 Inc.',
                           Phone= '9876787656', Email='test4@duptest.com');
            Lead lead3 = new Lead(LastName='Test3', Company='Test3 Inc.',
                            Phone= '9876787636',Email='test5@duptest.com');
            Lead[] leads = new Lead[] {lead1, lead2, lead3};
            insert leads;
            System.debug('leads***************'+leads);
       
            Lead dup1 = new Lead(LastName='Test1Dup', Company='Test1Dup Inc.',
                      Phone= '9876787636',Email='test4@duptest.com');
            Lead dup2 = new Lead(LastName='Test2Dup',
                           Company='Test2Dup Inc.',
                          Phone= '9876787636',  Email='test2@duptest.com');
            Lead dup3 = new Lead(LastName='Test3Dup',
                           Company='Test3Dup Inc.',
                          Phone= '9876787636', Email='test3@duptest.com');
            Lead[] dups = new Lead[] {dup1, dup2, dup3};
                 //insert dups;
        try {
			 insert dups;
			
        } catch (DmlException e) {
            String str= e.getMessage();
            System.assertEquals(true,str.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION, Duplicate Lead Found with  phone and Email: []'));

        }
    }
	public static testMethod void leadDuplicatePreventerNew(){
            Lead lead1 = new Lead(LastName='Test1', Company='Test1 Inc.',
                           Phone= '9876787653', Email='test1@duptest.com');
            Lead lead2 = new Lead(LastName='Test2', Company='Test2 Inc.',
                           Phone= '9876787656', Email='test41@duptest.com');
            Lead lead3 = new Lead(LastName='Test3', Company='Test3 Inc.',
                            Phone= '9876787636',Email='test5@duptest.com');
            Lead[] leads = new Lead[] {lead1, lead2, lead3};
            insert leads;
       // List<Lead> leadlist = [Select LastName, Company,Phone,Email];
            System.debug('leads****&&&'+leads);
        System.assertEquals(3,leads.size());
    }
	public static testMethod void leadDuplicatePreventerNewBulk(){
			List<Lead>  leadlist = new List<Lead>();
		    
		List <Lead> lead  = [SELECT LastName,Company,LeadSource,Status,Phone,Email from Lead ];
		List<Lead>  leadlist1 = new List<Lead>();
		    for(Integer i=0;i<100;i++){
        Lead leadObjnew = new Lead(LastName = 'Test',Company = 'Zen4orce',LeadSource = 'web',Status = 'Open - Not Contacted',Phone= '3434545654', Email='test29@duptest.com');
            leadlist1.add(leadObjnew);
			    }
        try {
			insert leadlist1;
			
        } catch (DmlException e) {
            String str= e.getMessage();
            System.assertEquals(true,str.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION, Duplicate Lead Found with  phone and Email: []'));

        }
        
	}
	public static testMethod void CreateCloneLeadPositive(){
	
		List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Open - Not Contacted');
            leadList.add(l1);
        }
        Database.SaveResult[] srList = Database.insert(leadList, false);
        List<Lead> dupLead = [SELECT id,LastName,Status  FROM Lead WHERE Status = 'Working - Contacted'];
        system.assertEquals(50, dupLead.size());
    }
    public static testMethod void CreateCloneLeadNegative(){
		List <Lead> leadList=new List<Lead> ();
        for(Integer i=0;i<50;i++){
            Lead l1 = new Lead (LastName = 'Testing',Company = 'Zen4orce',Status = 'Closed - Converted');
            leadList.add(l1);
        }
        Database.SaveResult[] srList = Database.insert(leadList, false);
        List<Lead> dupLead = [SELECT id,LastName,Status  FROM Lead WHERE Status = 'Working - Contacted'];
        system.assertEquals(0, dupLead.size());
    }
 }