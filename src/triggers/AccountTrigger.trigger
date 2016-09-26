trigger AccountTrigger on Account(after update) {
    
    if ( trigger.isAfter ) {
      
            AccountTriggerHandler.onAfterUpdateAccount( Trigger.new ,  Trigger.oldMap);
        }
        
    }