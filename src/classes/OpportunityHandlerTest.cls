@isTest(seeAllData=false)
    private class OpportunityHandlerTest {

        public static testMethod void onAfterInsertOne(){
            List<Opportunity> opp = new List<Opportunity>();
             for(Integer i=0;i<100;i++){
                Opportunity opp1 = new Opportunity(Name ='Test Opp',CloseDate = system.today(),Amount = 30000,StageName = 'Closed Won');
                 opp.add(opp1);
            }
               
         Database.SaveResult[] srList = Database.insert(opp, false);
            for (Database.SaveResult sr : srList) {
        if (sr.isSuccess()) {
       
            System.debug('Successfully inserted account. Account ID: ' + sr.getId());
        }else {
                   
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                 }
            }
        }
        public static testMethod void onAfterInsertTwo(){
            List<Opportunity> opp = new List<Opportunity>();
             for(Integer i=0;i<100;i++){
                Opportunity opp1 = new Opportunity(Name ='Test Opp',CloseDate = system.today(),Amount = 20000,StageName = 'Closed Won');
                 opp.add(opp1);
            }
               
         Database.SaveResult[] srList = Database.insert(opp, false);
            for (Database.SaveResult sr : srList) {
        if (sr.isSuccess()) {
       
            System.debug('Successfully inserted account. Account ID: ' + sr.getId());
        }else {
                   
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                 }
            }
        }
    }