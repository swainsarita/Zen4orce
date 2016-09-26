trigger updateImageOnBio on Attachment (after insert, after update) 
{
    Id imageId;
    Id attachparentId;
    
    for(Attachment at:trigger.new)
    {
        imageId=at.Id;
        attachparentId =at.ParentId;
    }
    System.debug(imageId);
    BioBriefing__c biolist= [SELECT Id,Attachment_Id__c FROM BioBriefing__c WHERE Id=:attachparentId limit 1];
    biolist.Attachment_Id__c = imageId;
    System.debug('@@@@@@@@@'+biolist.Attachment_Id__c);
    update biolist;
}