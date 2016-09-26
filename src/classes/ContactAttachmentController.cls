public class ContactAttachmentController{
    public Contact webContact{get;set;}
    public ContactAttachmentController(ApexPages.StandardController stdController){
      this.webContact = (Contact)stdController.getRecord();
      showErrorString=ApexPages.currentPage().getParameters().get('showError');
      if (showErrorString == 'TRUE') {
          showError = TRUE;
      }
    }
    
    public Attachment attach = new Attachment();
    public Blob bl {get; set;}
    public String contentType {get; set;}
    public String fileName {get; set;}
    public String VFPageURL {get; set;}
    public String errorMessage {get; set;}    
    public boolean showError {get; set;}
    public String showErrorString {get; set;}
        
    public PageReference save(){
        
        VFPageURL = '/apex/Attachments_Contacts?id=' + webContact.Id;
        if (bl != NULL) {
          attach.OwnerId = UserInfo.getUserId();
          attach.ParentId = webContact.Id;
          attach.Name = fileName;
          attach.Body = bl;
          attach.ContentType = contentType;
          showErrorString = 'FALSE';
          showError = FALSE;
          
          try {
            insert attach;
          } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
          return null;
          } finally {
            attach = new Attachment();
          }
        } else {
          VFPageURL += '&showError=TRUE';
        }
                 
        PageReference p= new PageReference(VFPageURL);
        p.setRedirect(true);
        return p;
    }
}