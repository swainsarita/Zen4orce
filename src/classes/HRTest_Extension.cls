public class HRTest_Extension {
	private final HR__c hr1;
    public String errorMessage { get; set; }
    public ApexPages.StandardController stdController{get;set;}
    
    public HRTest_Extension(apexpages.standardController stdController){
        this.hr1 = (HR__c)stdController.getRecord();
        this.stdController = stdController;
    }
        public  PageReference activateuser(){
            try{
                User u1 = new User();
                u1.ProfileId = '00e28000001m5x9';
                u1.IsActive = TRUE;
                u1.Username= hr1.Email__c;
                u1.Email = hr1.Email__c;
                u1.Lastname = hr1.Last_Name__c; 
                u1.Firstname = hr1.First_Name__c;
                u1.Alias = 'Sarita';
                u1.CommunityNickname = 'sar001';
                u1.UserRole = [ select id from userrole where id ='00E28000001QlY5' ];
                u1.Profile = [ select id from profile where id = '00e28000001m5x9' ];
                u1.TimeZoneSidKey = 'GMT';
                u1.LocaleSidKey = 'en_US';
                u1.EmailEncodingKey = 'ISO-8859-1';
                u1.LanguageLocaleKey = 'en_US';
                u1.UserPermissionsMobileUser = false; 
                insert u1;
                
                system.debug('new user'+u1.Id);
                hr1.User__c = u1.id;
                system.debug('hr'+hr1.User__c);
                update hr1;
                return (new ApexPages.StandardController(hr1)).view();
            }
            catch(System.Exception ex) {
            errorMessage = ex.getMessage();
            return null;
        }

}
}