trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    List<Task> taskList = new List<Task>();
    System.debug('@@@@******'+ taskList);
    for (Opportunity opp: trigger.new) 
        if(opp.StageName != null && opp.StageName == 'Closed Won'){
    
        task taskvalues = new task (WhatId = opp.Id, Subject = 'Follow Up Test Task');
        
        taskList.add(taskvalues);
    }
    
        
    if (taskList.size () > 0 ) {
        insert taskList;
        System.debug('@@@@'+ taskList);
    }
}