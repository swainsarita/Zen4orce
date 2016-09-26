public  with sharing class BioBrief_MyExtension {
  
    public BioBriefing__c cont;
    public blob picture {get;set;}

 public BioBrief_MyExtension(ApexPages.StandardController st){
  this.cont = (BioBriefing__c) st.getRecord();
 }
 /*public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = cont.id; // the record the file is attached to
    attachment.IsPrivate = true;

    try {
      insert attachment;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }*/
    public PageReference save() {
 PageReference pr ;
  try{
     insert cont;
     if(picture !=null) {
      Attachment attachment = new Attachment();
        attachment.body = picture;
        attachment.name = 'Contact_' + cont.id + '.jpg';
        attachment.parentid = cont.id;
        attachment.ContentType = 'application/jpg';
        insert attachment;
     cont.Attachment_Id__c = 'https://c.ap2.content.force.com/servlet/servlet.FileDownload?file=' +attachment.id;
                update cont;
       Pr = new PageReference('/'+cont.id);
       pr.setRedirect(true);
    }
   
  
  } catch(Exception  e){
   system.debug('Error Message==>'+e);
  }
 
  return pr;

}
}