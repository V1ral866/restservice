public class Log {

    
    public final static String TYPE_SUCCESS = 'SUCCESS';
    public final static String TYPE_ERROR = 'ERROR';

    public static void log(String type, String msg) {
       insert new CustomLog__c(Type__c = type, Msg__c=msg, Time__c=DateTime.now());
    }

    public static void success(String msg) {
        insert new CustomLog__c(Type__c = TYPE_SUCCESS, Msg__c=msg, Time__c=DateTime.now());
    }

    public static void error(String msg) {
        insert new CustomLog__c(Type__c = TYPE_ERROR, Msg__c=msg, Time__c=DateTime.now());
    }
}