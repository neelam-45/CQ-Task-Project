trigger TriggerOnAccount on Account (after insert , after update) {
    public static final String ACCOUNT_PERMISSION = 'Account_Permission_set';
    Boolean hasPermission = FeatureManagement.checkPermission(ACCOUNT_PERMISSION);
    if(Trigger.isAfter && Trigger.isInsert && hasPermission){
        AccountTriggerHandlerClass.isAfterInsert(Trigger.New);
    }
    if(Trigger.isAfter && Trigger.isUpdate && hasPermission){
        AccountTriggerHandlerClass.isAfterUpdate(Trigger.New);
    }
}