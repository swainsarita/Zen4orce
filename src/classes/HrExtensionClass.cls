public class HrExtensionClass {
    HR__c currentRecord;
    user userObg{get;set;}
    public Id Aid {get;set;}
    public HrExtensionClass(ApexPages.StandardController controller) {
         System.debug('@@@@controller@@@@********'+controller);
        Aid=controller.getId();
        System.debug('@@@@Aid@@@@'+Aid);
        currentRecord = [SELECT Id, Name, Email__c FROM HR__c WHERE Id = : Aid];
         System.debug('@@@@currentRecord@@@@'+currentRecord);
    }
      
   public PageReference activeUser() {
        
        PageReference orderPage = new PageReference('/005/e?id=' );
       orderPage .getParameters().put('userObg.FirstName',currentRecord.Name);
       if(currentRecord.Name != NULL){
           userObg.Email = currentRecord.Email__c;
           insert userObg;
           System.debug('userObg'+userObg);
           currentRecord.User__c = userObg.id;
           update currentRecord;
           System.debug('currentRecord'+currentRecord);
       }

        orderPage.setRedirect(true);
        return orderPage;
    }
}