public class ContactPhotoExtension {

public Contact cont;
public blob picture {get;set;}

 public ContactPhotoExtension(ApexPages.StandardController st){
  this.cont = (Contact) st.getRecord();
 
 }
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
     cont.Srinivas_Images_Path__c = 'https://c.ap2.content.force.com/servlet/servlet.FileDownload?file='+ attachment.id;
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