trigger UpdateAccountOwner on Account(after update) {
    
    if ( trigger.isAfter ) {
      
            ObjectTriggerHandler.onAfterUpdateAccount( Trigger.new ,  Trigger.oldMap);
        }
        
    }