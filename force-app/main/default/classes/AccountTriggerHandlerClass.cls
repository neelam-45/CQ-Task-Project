public class AccountTriggerHandlerClass {
    public static void isAfterInsert(List<Account> acclist){
        List<Contact> conList = new List<Contact>();
        for(Account acc : acclist){
            if(acc.Active__c == true){
                Contact conObj = new Contact();
                conObj.LastName = acc.Name + ' Customer Representative';
                conObj.AccountId = acc.Id;
                conList.add(conObj);
            }
        }
        if(conList.size() != 0){
            insert conList;
        }
    }
    public static void isAfterUpdate(List<Account> acclist){
        List<Account> accData = [select Account_Activation_Summary__c,Active__c,Name,id,(select Id from Contacts) from Account where Id In: acclist];
        List<Contact> conList = new List<Contact>();
        for(Account acc : accData){
            for(Account acc1 :acclist){
                if(acc.Id == acc1.id){
                    List<Contact> conData = acc.Contacts;
                    String accSummary = acc.Account_Activation_Summary__c;
                    if(!String.isBlank(acc.Account_Activation_Summary__c) ){
                        if(acc.Active__c == true && conData.size() < 1){
                            Contact conObj = new Contact();
                            conObj.LastName = acc.Name + ' Customer Representative';
                            conObj.AccountId = acc.Id;
                            conList.add(conObj);
                        }
                    }
                    else{
                        acc1.addError('Account activation summary is blank');
                    }
                }
                
            }
            
        }
        if(conList.size() != 0){
            insert conList;
        }
    }
}