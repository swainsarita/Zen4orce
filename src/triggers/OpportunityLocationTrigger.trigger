trigger OpportunityLocationTrigger on OpportunityLocation__c (before Update) {
    OpportunityLocationHandlerClass.BeforeUpdate(trigger.new);

}