public class OpportunityLocationHandlerClass {
	public static void BeforeUpdate (List<OpportunityLocation__c> oppLocList){
        List <HR__c> hrListe = new List<HR__c>([Select id, Name,Employee_No__c,Job_Code__c from HR__c ]);
        List<Contact> conlist = new List<Contact>([Select  Id,Employee_Id__c,Reports_To_Employee_Id__c ,LastName from Contact]);
        
         Map <String,Contact> conMap = new Map<String,Contact>();
         System.debug('TEst@@@@@conmap11'+conMap);
         Map<ID,HR__c> hrMap =  new Map<ID,HR__c>([Select iD,Name,Employee_No__c,Job_Code__c from HR__c ]);
         Map<String,HR__c> hrMap1 =  new Map<String,HR__c>();
        
        for(Contact newCon:conlist){
          conMap.put(newCon.Employee_Id__c, newCon);  
             System.debug('TEst@@@@@conmap'+conMap);
        }
        for( HR__c newHr :hrListe){
            hrMap1.put(newHr.Employee_No__c ,newHr);
            System.debug('newHr******'+newHr);
        }
        
	    for(OpportunityLocation__c oppLoc:oppLocList ){
			if(oppLoc.Current_Year_Rep__c != Null){
				if(hrMap.get(oppLoc.Current_Year_Rep__c).Employee_No__c != NULL){
						STRING OLP= hrMap.get(oppLoc.Current_Year_Rep__c).Employee_No__c;
							if(conMap.get(OLP)!= null ) {
								STRING OLPNew =  conMap.get(OLP).Reports_To_Employee_Id__c;
								System.debug('TEst2'+conMap.get(OLP).Reports_To_Employee_Id__c);
									if(hrMap1.get(OLPNew)!= null ){
										Id OLPNew1 = hrMap1.get(OLPNew).Id;
										oppLoc.CurrentYearManager__c = OLPNew1;
						}
					}
				}
		    }
			if(oppLoc.Product_Specialist__c != Null){
				if(hrMap.get(oppLoc.Product_Specialist__c).Employee_No__c != NULL){
					STRING OLP1= hrMap.get(oppLoc.Product_Specialist__c).Employee_No__c;
					if(conMap.get(OLP1)!= null){
						STRING OLPNewOne =  conMap.get(OLP1).Reports_To_Employee_Id__c;
						if(hrMap1.get(OLPNewOne)!= null){
							  Id OLPNew11 = hrMap1.get(OLPNewOne).Id;
								   oppLoc.ProductSpecialistManager__c = OLPNew11;
						}
					}
				}
		    }
			if(oppLoc.Second_Specialist__c != Null){
				if(hrMap.get(oppLoc.Second_Specialist__c).Employee_No__c != NULL){
					STRING OLP2= hrMap.get(oppLoc.Second_Specialist__c).Employee_No__c;
					if(conMap.get(OLP2)!= null){
						STRING OLPNewTwo =  conMap.get(OLP2).Reports_To_Employee_Id__c;
						if(hrMap1.get(OLPNewTwo)!= null){
							  Id OLPNew111 = hrMap1.get(OLPNewTwo).Id;
								   oppLoc.SecondSpecialistManger__c = OLPNew111;
						}
					}
			    }
			}
        } 
    }  
}