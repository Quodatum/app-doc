(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions to parse and serialize JSON documents. <a href="http://www.json.org/">JSON (JavaScript Object Notation)</a> is a popular data exchange format for applications written in JavaScript. As there are notable differences between JSON and XML, no mapping exists that guarantees a lossless, bidirectional conversion between JSON and XML. For this reason, we offer various mappings, all of which are suited to different use cases.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace json = "http://basex.org/modules/json";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Converts the JSON document specified by <code>$input</code> to an XML document or a map. If the input can be successfully parsed, it can be serialized back to the original JSON representation. The <code>$options</code> argument can be used to control the way the input is converted.
 :
 : @error bxerr:BXJS0001 the specified input cannot be parsed as JSON document.
 :)
declare function json:parse($input as xs:string) as element(json) external;

(:~
 : Converts the JSON document specified by <code>$input</code> to an XML document or a map. If the input can be successfully parsed, it can be serialized back to the original JSON representation. The <code>$options</code> argument can be used to control the way the input is converted.
 :
 : @error bxerr:BXJS0001 the specified input cannot be parsed as JSON document.
 :)
declare function json:parse($input as xs:string, $options as item()) as item() external;

(:~
 : Serializes the node specified by <code>$input</code> as JSON, and returns the result as <code>xs:string</code> instance. The node is expected to conform to the output created by the <a href="#json:parse">json:parse()</a> function. All other items will be serialized as specified for the <a href="http://docs.basex.org/wiki/XQuery_3.1#JSON_Serialization">json output method</a> of the official specification.
 : Items can also be serialized as JSON if the <a href="http://docs.basex.org/wiki/Serialization">Serialization Parameter</a>  <code>method</code> is set to <code>json</code> .
 : The <code>$options</code> argument can be used to control the way the input is serialized.
 :
 : @error bxerr:BXJS0002 the specified node cannot be serialized as JSON document.
 :)
declare function json:serialize($input as node()) as xs:string external;

(:~
 : Serializes the node specified by <code>$input</code> as JSON, and returns the result as <code>xs:string</code> instance. The node is expected to conform to the output created by the <a href="#json:parse">json:parse()</a> function. All other items will be serialized as specified for the <a href="http://docs.basex.org/wiki/XQuery_3.1#JSON_Serialization">json output method</a> of the official specification.
 : Items can also be serialized as JSON if the <a href="http://docs.basex.org/wiki/Serialization">Serialization Parameter</a>  <code>method</code> is set to <code>json</code> .
 : The <code>$options</code> argument can be used to control the way the input is serialized.
 :
 : @error bxerr:BXJS0002 the specified node cannot be serialized as JSON document.
 :)
declare function json:serialize($input as node(), $options as item()) as xs:string external;



