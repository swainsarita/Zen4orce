trigger LeadTrigger on Lead (before insert,before update,after update, after insert) {
    if ( trigger.isBefore ) {
      
            ObjectTriggerHandler.onBeforeUpdate(Trigger.new , trigger.oldmap,Trigger.isInsert,Trigger.isUpdate);
        }
    
    if ( trigger.isAfter) {
        
        if(trigger.isInsert){
            
           LeadTriggerHandler.onAfterInsert(Trigger.new); 
            }
        }
    if ( trigger.isBefore ) {
        
        if(trigger.isInsert || trigger.isUpdate){
            
           
          LeadTriggerHandler.leadDuplicatePreventer(Trigger.new );  
        }
        }
    if ( trigger.isBefore) {
        
        if(trigger.isInsert ){
            
          LeadTriggerHandler.CloneLead(Trigger.new); 
            }
        }
    }