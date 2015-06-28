(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions for performing admin-centric operations such as managing database users and log data.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace admin = "http://basex.org/modules/admin";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Returns an element sequence with all currently opened sessions, including the user name, address (IP:port) and an optionally opened database.
 : The output of this function and the <a href="http://docs.basex.org/wiki/Commands#SHOW_SESSIONS">SHOW SESSIONS</a> command is similar.
 :)
declare function admin:sessions() as element(session)* external;

(:~
 : Returns <a href="http://docs.basex.org/wiki/Logging">Logging</a> data compiled by the database or HTTP server: <ul> <li> If no argument is specified, a list of all log files will be returned, including the file size and date. </li> <li> If a <code>$date</code> is specified, the contents of a single log file will be returned. </li> <li> If <code>$merge</code> is set to true, related log entries will be merged. Please note that the merge might not be 100% successful, as log entries may be ambiguous. </li> </ul> 
 :)
declare function admin:logs() as element(file)* external;

(:~
 : Returns <a href="http://docs.basex.org/wiki/Logging">Logging</a> data compiled by the database or HTTP server: <ul> <li> If no argument is specified, a list of all log files will be returned, including the file size and date. </li> <li> If a <code>$date</code> is specified, the contents of a single log file will be returned. </li> <li> If <code>$merge</code> is set to true, related log entries will be merged. Please note that the merge might not be 100% successful, as log entries may be ambiguous. </li> </ul> 
 :)
declare function admin:logs($date as xs:string) as element(entry)* external;

(:~
 : Returns <a href="http://docs.basex.org/wiki/Logging">Logging</a> data compiled by the database or HTTP server: <ul> <li> If no argument is specified, a list of all log files will be returned, including the file size and date. </li> <li> If a <code>$date</code> is specified, the contents of a single log file will be returned. </li> <li> If <code>$merge</code> is set to true, related log entries will be merged. Please note that the merge might not be 100% successful, as log entries may be ambiguous. </li> </ul> 
 :)
declare function admin:logs($date as xs:string, $merge as xs:boolean) as element(entry)* external;

(:~
 : Writes a string to the database logs, along with current user data (timestamp, user name). If the function is called in a web application or a database client, the IP will be logged. Otherwise, the string <code>STANDALONE</code> will be logged.
 :)
declare function admin:write-log($text as xs:string) as empty-sequence() external;



