(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> provides simple functions to fetch the content of resources identified by URIs. Resources can be stored locally or remotely and e.g. use the <code>file://</code> or <code>http://</code> scheme. If more control over HTTP requests is required, the <a href="http://docs.basex.org/wiki/HTTP_Module">HTTP Module</a> can be used. With the <a href="http://docs.basex.org/wiki/HTML_Module">HTML Module</a> , retrieved HTML documents can be converted to XML. The module has initially been inspired by <a href="http://www.zorba.io/documentation/2.9/modules/www.zorba-xquery.com_modules_fetch.html">Zorba’s Fetch Module</a> .
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace fetch = "x-http://basex.org/modules/fetch";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Fetches the resource referred to by the given URI and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:base64Binary</code> .
 :
 : @error bxerr:BXFE0001 the URI could not be resolved, or the resource could not be retrieved.
 :)
declare function fetch:binary($uri as xs:string) as xs:base64Binary external;

(:~
 : Fetches the resource referred to by the given URI and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:string</code> .
 :
 : @error bxerr:BXFE0001 the URI could not be resolved, or the resource could not be retrieved. Invalid XML characters will be ignored if the <code> <a href="http://docs.basex.org/wiki/Options#CHECKSTRINGS">CHECKSTRINGS</a> </code> option is turned off.
 : @error bxerr:BXFE0002 the specified encoding is not supported, or unknown.
 :)
declare function fetch:text($uri as xs:string) as xs:string external;

(:~
 : Fetches the resource referred to by the given URI and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:string</code> .
 :
 : @error bxerr:BXFE0001 the URI could not be resolved, or the resource could not be retrieved. Invalid XML characters will be ignored if the <code> <a href="http://docs.basex.org/wiki/Options#CHECKSTRINGS">CHECKSTRINGS</a> </code> option is turned off.
 : @error bxerr:BXFE0002 the specified encoding is not supported, or unknown.
 :)
declare function fetch:text($uri as xs:string, $encoding as xs:string) as xs:string external;

(:~
 : Fetches the resource referred to by the given <code>$uri</code> and returns it as an XML document.
 : The <code>$options</code> argument can be used to change the parsing behavior. Allowed options are all <a href="http://docs.basex.org/wiki/Options#Parsing">parsing</a> and <a href="http://docs.basex.org/wiki/Options#XML_Parsing">XML parsing</a> options in lower case. Options can be specified either...
 : <ul> <li> as children of an <code>&lt;options/&gt;</code> element, e.g. </li> </ul>  <pre class="brush:xml"> &lt;options&gt; &lt;chop value='false'/&gt; &lt;/options&gt; </pre>  <ul> <li> or as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xquery"> map { "chop": false() } </pre> 
 :
 : @error bxerr:BXFE0001 the URI could not be resolved, or the resource could not be retrieved.
 :)
declare function fetch:xml($uri as xs:string) as document-node() external;

(:~
 : Fetches the resource referred to by the given <code>$uri</code> and returns it as an XML document.
 : The <code>$options</code> argument can be used to change the parsing behavior. Allowed options are all <a href="http://docs.basex.org/wiki/Options#Parsing">parsing</a> and <a href="http://docs.basex.org/wiki/Options#XML_Parsing">XML parsing</a> options in lower case. Options can be specified either...
 : <ul> <li> as children of an <code>&lt;options/&gt;</code> element, e.g. </li> </ul>  <pre class="brush:xml"> &lt;options&gt; &lt;chop value='false'/&gt; &lt;/options&gt; </pre>  <ul> <li> or as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xquery"> map { "chop": false() } </pre> 
 :
 : @error bxerr:BXFE0001 the URI could not be resolved, or the resource could not be retrieved.
 :)
declare function fetch:xml($uri as xs:string, $options as item()) as document-node() external;

(:~
 : Returns the content-type (also called mime-type) of the resource specified by <code>$uri</code> : <ul> <li> If a remote resource is addressed, the request header will be evaluated. </li> <li> If the addressed resource is locally stored, the content-type will be guessed based on the file extension. </li> </ul> 
 :
 : @error bxerr:BXFE0001 the URI could not be resolved, or the resource could not be retrieved.
 :)
declare function fetch:content-type($uri as xs:string) as xs:string external;



