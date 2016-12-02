(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions for evaluating XQuery strings and modules at runtime.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace xquery = "x-http://basex.org/modules/xquery";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Evaluates the supplied <code>$query</code> string as XQuery expression and returns the resulting items.
 : The evaluated query has its own query context. If a returned node is stored in a database, a main-memory copy will be returned as result, because the referenced database is closed after query execution and will not be accessible anymore.
 : Variables and context items can be declared via <code>$bindings</code> . The specified keys must be QNames or strings: <ul> <li> If a key is a QName, it will be directly adopted as variable name. </li> <li> It a key is a string, it may be prefixed with a dollar sign. Namespace can be specified using the <a href="http://www.jclark.com/xml/xmlns.htm">Clark Notation</a>. </li> <li> If the specified string is empty, the value will be bound to the context item. </li> </ul>  <p>The <code>$options</code> parameter contains evaluation options, which can either be specified </p>  <ul> <li> as children of an <code>&lt;xquery:options/&gt;</code> element: </li> </ul>  <pre class="brush:xml"> &lt;xquery:options&gt; &lt;xquery:permission value="none"/&gt; &lt;/xquery:options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "permission": "none" } </pre>  <p>The following options are available: </p>  <ul> <li> <code>permission</code>: the query will be evaluated with the specified permissions (see <a href="http://docs.basex.org/wiki/User_Management">User Management</a>). </li> <li> <code>timeout</code>: query execution will be interrupted after the specified number of seconds. </li> <li> <code>memory</code>: query execution will be interrupted if the specified number of megabytes will be exceeded. This check works best if only one process is running at the same time. </li> </ul> 
 :
 : @error bxerr:BXXQ0001 the query contains <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout or memory constraints.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:eval($query as xs:string) as item()* external;

(:~
 : Evaluates the supplied <code>$query</code> string as XQuery expression and returns the resulting items.
 : The evaluated query has its own query context. If a returned node is stored in a database, a main-memory copy will be returned as result, because the referenced database is closed after query execution and will not be accessible anymore.
 : Variables and context items can be declared via <code>$bindings</code> . The specified keys must be QNames or strings: <ul> <li> If a key is a QName, it will be directly adopted as variable name. </li> <li> It a key is a string, it may be prefixed with a dollar sign. Namespace can be specified using the <a href="http://www.jclark.com/xml/xmlns.htm">Clark Notation</a>. </li> <li> If the specified string is empty, the value will be bound to the context item. </li> </ul>  <p>The <code>$options</code> parameter contains evaluation options, which can either be specified </p>  <ul> <li> as children of an <code>&lt;xquery:options/&gt;</code> element: </li> </ul>  <pre class="brush:xml"> &lt;xquery:options&gt; &lt;xquery:permission value="none"/&gt; &lt;/xquery:options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "permission": "none" } </pre>  <p>The following options are available: </p>  <ul> <li> <code>permission</code>: the query will be evaluated with the specified permissions (see <a href="http://docs.basex.org/wiki/User_Management">User Management</a>). </li> <li> <code>timeout</code>: query execution will be interrupted after the specified number of seconds. </li> <li> <code>memory</code>: query execution will be interrupted if the specified number of megabytes will be exceeded. This check works best if only one process is running at the same time. </li> </ul> 
 :
 : @error bxerr:BXXQ0001 the query contains <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout or memory constraints.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:eval($query as xs:string, $bindings as map(*)) as item()* external;

(:~
 : Evaluates the supplied <code>$query</code> string as XQuery expression and returns the resulting items.
 : The evaluated query has its own query context. If a returned node is stored in a database, a main-memory copy will be returned as result, because the referenced database is closed after query execution and will not be accessible anymore.
 : Variables and context items can be declared via <code>$bindings</code> . The specified keys must be QNames or strings: <ul> <li> If a key is a QName, it will be directly adopted as variable name. </li> <li> It a key is a string, it may be prefixed with a dollar sign. Namespace can be specified using the <a href="http://www.jclark.com/xml/xmlns.htm">Clark Notation</a>. </li> <li> If the specified string is empty, the value will be bound to the context item. </li> </ul>  <p>The <code>$options</code> parameter contains evaluation options, which can either be specified </p>  <ul> <li> as children of an <code>&lt;xquery:options/&gt;</code> element: </li> </ul>  <pre class="brush:xml"> &lt;xquery:options&gt; &lt;xquery:permission value="none"/&gt; &lt;/xquery:options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "permission": "none" } </pre>  <p>The following options are available: </p>  <ul> <li> <code>permission</code>: the query will be evaluated with the specified permissions (see <a href="http://docs.basex.org/wiki/User_Management">User Management</a>). </li> <li> <code>timeout</code>: query execution will be interrupted after the specified number of seconds. </li> <li> <code>memory</code>: query execution will be interrupted if the specified number of megabytes will be exceeded. This check works best if only one process is running at the same time. </li> </ul> 
 :
 : @error bxerr:BXXQ0001 the query contains <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout or memory constraints.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:eval($query as xs:string, $bindings as map(*), $options as item()) as item() external;

(:~
 : Evaluates <code>$query</code> as updating XQuery expression at runtime.
 : All updates will be added to the <a href="http://docs.basex.org/wiki/XQuery_Update#Pending_Update_List">Pending Update List</a> of the main query and performed after the evaluation of the main query.
 :
 : @error bxerr:BXXQ0002 the query contains no <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout or memory constraints.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:update($query as xs:string) as item()* external;

(:~
 : Evaluates <code>$query</code> as updating XQuery expression at runtime.
 : All updates will be added to the <a href="http://docs.basex.org/wiki/XQuery_Update#Pending_Update_List">Pending Update List</a> of the main query and performed after the evaluation of the main query.
 :
 : @error bxerr:BXXQ0002 the query contains no <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout or memory constraints.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:update($query as xs:string, $bindings as map(*)) as item()* external;

(:~
 : Evaluates <code>$query</code> as updating XQuery expression at runtime.
 : All updates will be added to the <a href="http://docs.basex.org/wiki/XQuery_Update#Pending_Update_List">Pending Update List</a> of the main query and performed after the evaluation of the main query.
 :
 : @error bxerr:BXXQ0002 the query contains no <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout or memory constraints.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:update($query as xs:string, $bindings as map(*), $options as item()) as item() external;

(:~
 : Parses the specified <code>$query</code> string as XQuery module and returns information on the resulting query plan (please note that the naming of the expressions in the query plan may change over time). The <code>$options</code> parameters can be specified in two ways: <ul> <li> as children of an <code>&lt;xquery:options/&gt;</code> element: </li> </ul>  <pre class="brush:xml"> &lt;xquery:options&gt; &lt;xquery:compile value="true"/&gt; &lt;/xquery:options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "compile": true() } </pre>  <p>The following options are available: </p>  <ul> <li> <code>compile</code>: additionally compiles the query after parsing it. By default, this option is <code>false</code>. </li> <li> <code>plan</code>: returns an XML representation of the internal query plan. By default, this option is <code>true</code>. </li> </ul> 
 :)
declare function xquery:parse($query as xs:string) as item()* external;

(:~
 : Parses the specified <code>$query</code> string as XQuery module and returns information on the resulting query plan (please note that the naming of the expressions in the query plan may change over time). The <code>$options</code> parameters can be specified in two ways: <ul> <li> as children of an <code>&lt;xquery:options/&gt;</code> element: </li> </ul>  <pre class="brush:xml"> &lt;xquery:options&gt; &lt;xquery:compile value="true"/&gt; &lt;/xquery:options&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "compile": true() } </pre>  <p>The following options are available: </p>  <ul> <li> <code>compile</code>: additionally compiles the query after parsing it. By default, this option is <code>false</code>. </li> <li> <code>plan</code>: returns an XML representation of the internal query plan. By default, this option is <code>true</code>. </li> </ul> 
 :)
declare function xquery:parse($query as xs:string, $options as item()) as item() external;

(:~
 : Opens <code>$uri</code> as file, evaluates it as XQuery expression at runtime, and returns the resulting items. Database nodes in the result will be copied and returned instead.
 : The semantics of the <code>$bindings</code> and <code>$options</code> parameters is the same as for <a href="#xquery:eval">xquery:eval</a> .
 :
 : @error bxerr:BXXQ0001 the expression contains <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:invoke($uri as xs:string) as item()* external;

(:~
 : Opens <code>$uri</code> as file, evaluates it as XQuery expression at runtime, and returns the resulting items. Database nodes in the result will be copied and returned instead.
 : The semantics of the <code>$bindings</code> and <code>$options</code> parameters is the same as for <a href="#xquery:eval">xquery:eval</a> .
 :
 : @error bxerr:BXXQ0001 the expression contains <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:invoke($uri as xs:string, $bindings as map(*)) as item()* external;

(:~
 : Opens <code>$uri</code> as file, evaluates it as XQuery expression at runtime, and returns the resulting items. Database nodes in the result will be copied and returned instead.
 : The semantics of the <code>$bindings</code> and <code>$options</code> parameters is the same as for <a href="#xquery:eval">xquery:eval</a> .
 :
 : @error bxerr:BXXQ0001 the expression contains <a href="http://docs.basex.org/wiki/XQuery_Update#Updating_Expressions">updating expressions</a> .
 : @error bxerr:BXXQ0003 insufficient permissions for evaluating the query.
 : @error bxerr:BXXQ0004 query execution exceeded timeout.
 : @error bxerr:FOTY0013 the expression yields function items.
 :)
declare function xquery:invoke($uri as xs:string, $bindings as map(*), $options as item()) as item()* external;

(:~
 : Similar to <code>fn:trace($expr, $msg)</code> , but instead of a user-defined message, it emits the compile-time type and estimated result size of its argument.
 :)
declare function xquery:type($expr as item()*) as item()* external;



