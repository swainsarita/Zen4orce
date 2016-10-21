public with sharing class QueryBuilderDesign {
    public list<Selectoption> lstOptions {get;set;}
    public String selectedstage{get;set;}
    public String selectedObject{get;set;}
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<Selectoption> lstfieldname{get;set;}
    public List<Sobject> lstObject{get;set;}
    public List<String> lstSelectedFields{get;set;}
    public String strQuery{get;set;}
    public String selectedRadio{get;set;}
    public String ConId ;
    public QueryBuilderDesign(){
        try
        {
            lstOptions = new List<Selectoption>();
            lstfieldname=new List<Selectoption>();
            lstObject=new List<Sobject>();
            lstOptions.add(new Selectoption('','--None--'));
            for(Schema.Sobjecttype objSobject: schemaMap.values())
            {           
                if(objSobject.getDescribe().isQueryable())          
                    lstOptions.add(new Selectoption(objSobject.getDescribe().getname(),objSobject.getDescribe().getLabel()));
            }
            lstOptions.sort();
            selectedRadio = 'ASC';
        }catch(Exception e){
            if(lstOptions.isEmpty())
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'There is No Objects!!'));
        }
    }
    public void getFields(){
        try
        {
            lstfieldname.clear();
            Map<String,schema.Sobjectfield> mapFields=schemaMap.get(selectedObject).getDescribe().fields.getMap();     
            for(schema.Sobjectfield objSobjectFeild:mapFields.values())
                lstfieldname.add(new Selectoption(objSobjectFeild.getDescribe().getname(),objSobjectFeild.getDescribe().getLabel ()));
        }catch(Exception e){
        }
    }
    public void getValue(){
        lstObject = new List<Sobject>();
        strQuery = 'Select ' +            
        String.join( lstSelectedFields, ',' ) +  
             ' from ' + selectedObject + ' ORDER BY ' + ' CreatedDate ' + selectedRadio +  ' LIMIT '+selectedstage ; 
    }
    public void getRecords(){
        try
        {
            lstObject = Database.query(strQuery) ;
        } 
        catch(Exception e)
        {
            if(lstObject.isEmpty())
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO,'There is No Records!!'));
        }
    }
    public List<SelectOption> getstagelist(){
        List<SelectOption> stagelist=new List<SelectOption>();
        stagelist.add(new SelectOption('5','5'));
        stagelist.add(new SelectOption('1000','1000'));
        stagelist.add(new SelectOption('5000','5000'));
        stagelist.add(new SelectOption('50000','50000'));
        
        return stagelist;
    }
    public list<SelectOption> getRadioValue(){
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('ASC', 'Ascending'));
        options.add(new SelectOption('DESC', 'Descending'));
    
        return options;
    }
    public void clearValues(){
        System.debug('CLEAR *************');
        lstSelectedFields = new List<String>();
        lstObject = new List<Sobject>();
        selectedObject = '';
         strQuery = '';
        lstfieldname = new List<Selectoption>();
    }
    
}