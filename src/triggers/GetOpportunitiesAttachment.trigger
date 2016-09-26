trigger GetOpportunitiesAttachment on Attachment(after insert, after update, before delete, after undelete){
try{
  List<Opportunity> oppList = new List<Opportunity>();
  //Set of Opportunity Ids that we will iterate through
  Set<id> oppIds = new Set<id>();
  for(Attachment attach : Trigger.IsDelete ? Trigger.old : Trigger.new){
String parentObjId = attach.ParentId;
//006 is the starting sting in ID for all opportunities
if(parentObjId.startsWith('006')){
      oppIds.add(attach.ParentId);
    }
  }
  // Get the Opportunity id and Consultant_Signature__c  for each Opportunity
  Map<id, Opportunity> oppMap = new Map<id, Opportunity>([Select id, Consultant_Signature__c, Applicant_Signature__c from Opportunity Where Id in :oppIds]);  
  for(Attachment attach : Trigger.IsDelete ? Trigger.old : Trigger.new){
String parentObjId = attach.ParentId;
//006 is the starting sting in ID for all opportunities
if(parentObjId.startsWith('006')){
      Opportunity opp = oppMap.get(attach.ParentId);
String imageURL ='/servlet/servlet.FileDownload?file=';
String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm() + imageURL + attach.id;
system.debug(fullFileURL);
opp.Consultant_Signature__c = null;
opp.Applicant_Signature__c = null;
if(!Trigger.IsDelete){
if(attach.Name == 'Consultant_Signature.jpeg' || attach.Name == 'Consultant Signature.jpeg' || attach.Name == 'Consultant_Signature.jpg' || attach.Name == 'Consultant Signature.jpg' || attach.Name == 'Consultant_Signature.png' || attach.Name == 'Consultant Signature.png'){
          opp.Consultant_Signature__c = fullFileURL;
}
else if(attach.Name == 'Applicant_Signature.jpeg' || attach.Name == 'Applicant Signature.jpeg' || attach.Name == 'Applicant_Signature.jpg' || attach.Name == 'Applicant Signature.jpg' || attach.Name == 'Applicant_Signature.png' || attach.Name == 'Applicant Signature.png'){
          opp.Applicant_Signature__c = fullFileURL;
}
}
      oppList.add(opp);
}
  }
if(oppList != null && oppList.size() > 0){
    update oppList;
}
} 
catch(Exception e){
  System.debug('ERROR: '+ e);
}
}