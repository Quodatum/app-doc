(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions for accessing and modifying server-side session information. This module is mainly useful in the context of <a href="http://docs.basex.org/wiki/Web_Application">Web Applications</a> .
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace session = "x-http://basex.org/modules/session";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Returns the session ID of a servlet request.
 :)
declare function session:id() as xs:string external;

(:~
 : Returns the creation time of a session.
 :)
declare function session:created() as xs:dateTime external;

(:~
 : Returns the last access time of a session.
 :)
declare function session:accessed() as xs:dateTime external;

(:~
 : Returns the names of all variables bound to the current session.
 :)
declare function session:names() as xs:string* external;

(:~
 : Returns the value of a variable bound to the current session. If the key is unknown, an empty sequence or the optionally specified default value is returned instead.
 :
 : @error bxerr:BXSE0002 the value of a session variable could not be retrieved.
 :)
declare function session:get($key as xs:string) as item()* external;

(:~
 : Returns the value of a variable bound to the current session. If the key is unknown, an empty sequence or the optionally specified default value is returned instead.
 :
 : @error bxerr:BXSE0002 the value of a session variable could not be retrieved.
 :)
declare function session:get($key as xs:string, $default as item()*) as item()* external;

(:~
 : Binds the specified key/value pair to a session.
 :
 : @error bxerr:BXSE0001 a function item was specified as value of a session variable.
 :)
declare function session:set($key as xs:string, $value as item()*) as empty-sequence() external;

(:~
 : Deletes a session variable.
 :)
declare function session:delete($key as xs:string) as empty-sequence() external;

(:~
 : Unregisters a session and all data associated with it.
 :)
declare function session:close() as empty-sequence() external;



