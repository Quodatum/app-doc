(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains a single function to parse CSV input. <a href="http://en.wikipedia.org/wiki/Comma-separated_values">CSV</a> (comma-separated values) is a popular representation for tabular data, exported e. g. from Excel.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace csv = "http://basex.org/modules/csv";
declare namespace bxerr = "http://basex.org/errors";

(:~
 : Converts the CSV data specified by <code>$input</code> to an XML document or a map. The <code>$options</code> argument can be used to control the way the input is converted.
 :
 : @error bxerr:BXCS0001 the input cannot be parsed.
 :)
declare function csv:parse($input as xs:string) as document-node(element(csv)) external;

(:~
 : Converts the CSV data specified by <code>$input</code> to an XML document or a map. The <code>$options</code> argument can be used to control the way the input is converted.
 :
 : @error bxerr:BXCS0001 the input cannot be parsed.
 :)
declare function csv:parse($input as xs:string, $options as item()) as item() external;

(:~
 : Serializes the node specified by <code>$input</code> as CSV data, and returns the result as <code>xs:string</code> . Items can also be serialized as JSON if the <a href="http://docs.basex.org/wiki/Serialization">Serialization Parameter</a>  <code>method</code> is set to <code>csv</code> .
 : The <code>$options</code> argument can be used to control the way the input is serialized.
 :
 : @error bxerr:BXCS0002 the input cannot be serialized.
 :)
declare function csv:serialize($input as node()) as xs:string external;

(:~
 : Serializes the node specified by <code>$input</code> as CSV data, and returns the result as <code>xs:string</code> . Items can also be serialized as JSON if the <a href="http://docs.basex.org/wiki/Serialization">Serialization Parameter</a>  <code>method</code> is set to <code>csv</code> .
 : The <code>$options</code> argument can be used to control the way the input is serialized.
 :
 : @error bxerr:BXCS0002 the input cannot be serialized.
 :)
declare function csv:serialize($input as node(), $options as item()) as xs:string external;



