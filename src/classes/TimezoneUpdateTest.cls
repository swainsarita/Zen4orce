@isTest(seeAllData=false)
    private class TimezoneUpdateTest {

        public static testMethod void testLead(){
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
        
          
        }