trigger ContactTrigger on Contact (before update) {
    If(Trigger.isBefore){
        If(Trigger.isUpdate){
              ContactHandlerClass.changeAccountNameOnContact(trigger.new, trigger.OldMap);
           }

    }
    If(Trigger.isAfter){
         If(Trigger.isInsert || Trigger.isUpdate){
             ContactHandlerClass.changeContactOwnerOnContact(trigger.new);
          }

      }
}