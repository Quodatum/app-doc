(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions for creating and administering database users. The <a href="http://docs.basex.org/wiki/User_Management">User Management</a> article gives more information on database users and permissions.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace user = "http://basex.org/modules/user";

(:~
 : Returns the name of the currently logged in user.
 :)
declare function user:current() as xs:string external;

(:~
 : Returns the names of all registered users.
 :)
declare function user:list() as xs:string* external;

(:~
 : Returns an element sequence, containing all registered users and their permissions.
 : In addition to the <a href="http://docs.basex.org/wiki/Commands#SHOW_USERS">SHOW USERS</a> command, encoded password strings and database permissions will be output. A user <code>$name</code> can be specified to filter the results in advance.
 :
 : @error :unknown The specified user name is unknown.
 :)
declare function user:list-details() as element(user)* external;

(:~
 : Returns an element sequence, containing all registered users and their permissions.
 : In addition to the <a href="http://docs.basex.org/wiki/Commands#SHOW_USERS">SHOW USERS</a> command, encoded password strings and database permissions will be output. A user <code>$name</code> can be specified to filter the results in advance.
 :
 : @error :unknown The specified user name is unknown.
 :)
declare function user:list-details($name as xs:string) as element(user)* external;

(:~
 : Checks if a user with the specified <code>$name</code> exists.
 :
 : @error :name The specified user name is invalid.
 :)
declare function user:exists($name as xs:string) as xs:boolean external;

(:~
 : Creates a new user with the specified <code>$name</code> and <code>$password</code> . The default permission <code>none</code> can be overwritten with the <code>$permission</code> argument. Existing users will be overwritten.
 :
 : @error :name The specified user name is invalid.
 : @error :permission The specified permission is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 :)
declare function user:create($name as xs:string, $password as xs:string) as empty-sequence() external;

(:~
 : Creates a new user with the specified <code>$name</code> and <code>$password</code> . The default permission <code>none</code> can be overwritten with the <code>$permission</code> argument. Existing users will be overwritten.
 :
 : @error :name The specified user name is invalid.
 : @error :permission The specified permission is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 :)
declare function user:create($name as xs:string, $password as xs:string, $permission as xs:string) as empty-sequence() external;

(:~
 : Grants the specified <code>$permission</code> to a user with the specified <code>$name</code> . If a glob <code>$pattern</code> is specified, the permission will only be applied to databases matching that pattern.
 :
 : @error :unknown The specified user name is unknown.
 : @error :name The specified user name is invalid.
 : @error :pattern The specified database pattern is invalid.
 : @error :permission The specified permission is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :local A local permission can only be 'none', 'read' or 'write'.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 :)
declare function user:grant($name as xs:string, $permission as xs:string) as empty-sequence() external;

(:~
 : Grants the specified <code>$permission</code> to a user with the specified <code>$name</code> . If a glob <code>$pattern</code> is specified, the permission will only be applied to databases matching that pattern.
 :
 : @error :unknown The specified user name is unknown.
 : @error :name The specified user name is invalid.
 : @error :pattern The specified database pattern is invalid.
 : @error :permission The specified permission is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :local A local permission can only be 'none', 'read' or 'write'.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 :)
declare function user:grant($name as xs:string, $permission as xs:string, $pattern as xs:string) as empty-sequence() external;

(:~
 : Drops a user with the specified <code>$name</code> . If a glob <code>$pattern</code> is specified, only the database pattern will be dropped.
 :
 : @error :unknown The specified user name is unknown.
 : @error :name The specified user name is invalid.
 : @error :pattern The specified database pattern is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 : @error :conflict A user cannot be both altered and dropped.
 :)
declare function user:drop($name as xs:string) as empty-sequence() external;

(:~
 : Drops a user with the specified <code>$name</code> . If a glob <code>$pattern</code> is specified, only the database pattern will be dropped.
 :
 : @error :unknown The specified user name is unknown.
 : @error :name The specified user name is invalid.
 : @error :pattern The specified database pattern is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 : @error :conflict A user cannot be both altered and dropped.
 :)
declare function user:drop($name as xs:string, $pattern as xs:string) as empty-sequence() external;

(:~
 : Renames a user with the specified <code>$name</code> to <code>$newname</code> .
 :
 : @error :unknown The specified user name is unknown.
 : @error :name The specified user name is invalid.
 : @error :admin The "admin" user cannot be modified.
 : @error :logged-in The specified user is currently logged in.
 : @error :update The operation can only be performed once per user or database pattern.
 : @error :conflict A user cannot be both altered and dropped.
 :)
declare function user:alter($name as xs:string, $newname as xs:string) as empty-sequence() external;

(:~
 : Changes the <code>password</code> of a user with the specified <code>$name</code> .
 :
 : @error :unknown The specified user name is unknown.
 : @error :name The specified user name is invalid.
 : @error :update The operation can only be performed once per user or database pattern.
 :)
declare function user:password($name as xs:string, $password as xs:string) as empty-sequence() external;



