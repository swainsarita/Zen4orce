trigger UpdateTimezone on Lead (before insert,before update,after update) {
    if ( trigger.isBefore ) {
      
            ObjectTriggerHandler.onBeforeUpdate(Trigger.new , trigger.oldmap,Trigger.isInsert,Trigger.isUpdate);
        }
      if ( trigger.isAfter ) {

        }
        
    }