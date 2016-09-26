public class AccountOwnerReplaceOnContact {
    Public static void onAfterUpdate(List<Contact>conlist ,Map<Id,Contact>conMap, Map<Id,Contact>conMapNew){
        Set<Id> ConId = new Set<Id>();
        List<Contact>conlist1 = new List<Contact>();
        For(Contact newCon :conlist){
            If(newCon.AccountId != conMap.get(newCon.Id).AccountId){
                ConId.add(newCon.id);
            }
        }
         
        If (ConId.size()>0){
            For(ID id:ConId){
                
            }
            
        }
    }

}