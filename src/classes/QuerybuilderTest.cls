@isTest
public class QuerybuilderTest {
    Public static testmethod void MyTest(){
        List<Sobject> objList = new List<Sobject>();
        List<SelectOption> stagelist=new List<SelectOption>();
       
        QueryBuilderDesign qbd =  new QueryBuilderDesign();
            qbd.selectedObject = 'Account';
            qbd.getFields();
            qbd.lstSelectedFields =  new List<String>();
            qbd.lstSelectedFields.add('Name');       
            qbd.lstSelectedFields.add('Id');
            qbd.lstSelectedFields.add('OwnerId');
            qbd.lstSelectedFields.add('AccountNumber');
            qbd.lstSelectedFields.add('AnnualRevenue');
            qbd.selectedstage = '5';
            qbd.getstagelist();
            qbd.lstfieldname= stagelist;
            qbd.lstObject = objList ;
            qbd.selectedRadio = 'ASC';
           
            qbd.getValue();
            qbd.getRecords();
            qbd.getRadioValue();
            
        system.assertEquals('5', qbd.selectedstage);
        system.assertEquals('ASC', qbd.selectedRadio);
        system.assertEquals('Select Name,Id,OwnerId,AccountNumber,AnnualRevenue from Account ORDER BY  CreatedDate ASC LIMIT 5',qbd.strQuery);
        qbd.clearValues();
    }
    Public static testmethod void MyTest2(){
        List<Sobject> objList = new List<Sobject>();
        List<SelectOption> stagelist=new List<SelectOption>();
        QueryBuilderDesign qbd =  new QueryBuilderDesign();
            qbd.selectedObject = '';
            qbd.getFields();
            qbd.lstSelectedFields =  new List<String>();
            qbd.lstSelectedFields.add('Name');       
            qbd.lstSelectedFields.add('Id');
            qbd.lstSelectedFields.add('OwnerId');
            qbd.lstSelectedFields.add('AccountNumber');
            qbd.lstSelectedFields.add('AnnualRevenue');
            qbd.selectedstage = '';
            qbd.getstagelist();
            qbd.lstfieldname= stagelist;
            qbd.lstObject = objList ;
            qbd.selectedRadio = 'ASC';
           
            qbd.getValue();
            qbd.getRecords();
            //qbd.clearValues();
            system.assertEquals('Select Name,Id,OwnerId,AccountNumber,AnnualRevenue from  ORDER BY  CreatedDate ASC LIMIT ',qbd.strQuery);
        qbd.clearValues();
    }
}