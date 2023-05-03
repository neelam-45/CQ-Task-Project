@isTest
public class AccountTriggerHandlerClass_Test {
    
    //Setup data for test
    @TestSetup
    public static void testDataCreate(){
        // Create test accounts
        Account accObj = new Account(Name='Test Account 1', Active__c=false,Account_Activation_Summary__c='Test');
        insert accObj;
    }
    
    @isTest
    public static void testAfterInsertAccount(){
        
        // Create account test record
        Account accObj = new Account(Name='Test Account', Active__c=true);
        
        // Insert Account
        insert accObj;
        
        List<Contact> conList = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId = :accObj.Id];
        
        // Verify that contacts were created for active accounts only
        System.assertEquals(conList.size(),1,'Customer Representative Created');
        
    }
    
    @isTest
    public static void testAfterUpdateAccount(){
        
        // Get account test record
        Account accObj = [SELECT Id, Name FROM Account Where Name = 'Test Account 1' Limit 1];
        
        accObj.Active__c = true;
        update accObj;
        
        List<Contact> conList = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId = :accObj.Id];
        
        // Verify that contacts were created for active accounts only
        System.assertEquals(conList.size(),1,'Customer Representative Created');
        
    }
}