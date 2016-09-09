trigger UpdateContactOwner on Contact(after insert,after update) {
    
    if ( trigger.isAfter ) {
      
            ObjectTriggerHandler.changeContactOwner( Trigger.new, Trigger.old );
        }
        
    }