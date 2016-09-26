trigger CreateTaskOnLead on Lead (after insert) {
    List<Task> lTask = new List<Task>();
      Task t;
     
        if(Trigger.isInsert) {
           for(Lead l: Trigger.new) {
               
               if((l.LeadSource != null)&&(l.LeadSource == 'Web')){
                 t = new Task(); 
                 t.OwnerId = l.OwnerId;
                 t.WhoId = l.id;
                 //t. WhoId = l.Id;
                 t.Subject = 'Lead Web Comment';
                 t.Priority = 'Normal';
                 t.Status = 'Not Started';
                 t.Description = l.Description;
                 lTask.add(t);   
               }
            }
            if(!lTask.IsEmpty())
                insert lTask;
                 
      }
}