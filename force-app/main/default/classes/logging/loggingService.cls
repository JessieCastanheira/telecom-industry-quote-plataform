public with sharing class loggingService {
    public enum LogLevel {
        DEBUG,
        INFO,
        WARN,
        ERROR    
    }

    public static void log(LogLevel level, String message){
        System.debug(formatMessage(level, message));
    }

    public static void debug(string message){
        log(LogLevel.DEBUG, message);
    }

    public static void info(string message){
        log(LogLevel.INFO, message);
    }

    public static void warn(string message){
        log(LogLevel.WARN, message);
    }

    public static void error(string message){
        log(LogLevel.ERROR, message);
    }


    private static string formatMessage(LogLevel level, string message){
        return '[' + level.name() + ']' + message;
    }
}