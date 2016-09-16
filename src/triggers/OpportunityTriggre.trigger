trigger OpportunityTriggre on Opportunity (after insert) {
    
    if ( trigger.isAfter ) {
        if(trigger.isInsert ){
          OpportunityHandlerClass.onAfterInsert(Trigger.new ,Trigger.newmap);  
        }

     }
}