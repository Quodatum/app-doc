(:~ 
 : schema stuff
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace xsd = 'apb.schema.rest';
declare default function namespace 'apb.schema.rest';

declare namespace xerces= "com.sun.org.apache.xerces.internal.impl.Version";

declare namespace Source= "javax.xml.transform.Source";
declare namespace StreamSource= "javax.xml.transform.stream.StreamSource";
declare namespace Schema= "javax.xml.validation.Schema";
declare namespace SchemaFactory= "javax.xml.validation.SchemaFactory";
declare namespace Validator= "javax.xml.validation.Validator";
declare namespace File="java:java.io.File";

declare variable $xsd:xproc:="C:\Users\andy\workspace\xprocdoc\schemas\xproc.xsd";

(:
 : @return version of xerces in use
 : @see http://cafe.elharo.com/xml/what-version-of-xerces-are-you-using/
 :)
declare function xerces-version(){
    xerces:getVersion()
}; 

declare function xproc($src){
let $xpl:=fn:doc($src)
return validate:xsd-info($xpl,$xsd:xproc)
};

declare function xproc2($src){
let $factory:=SchemaFactory:newInstance("http://www.w3.org/2001/XMLSchema")
let $xsd:=File:new($xsd:xproc)
let $schema := SchemaFactory:newSchema($factory,$xsd)

return $schema
}; 