(:~
 : transform xml with xslt
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";

declare variable $xml:="C:/Users/andy/git/ex-schematron/dist/doc/schematron.xqm.xml";
declare variable $xslt:="C:\Users\andy\workspace\app-doc\src\doc\xslt\html-module.xsl";
declare variable $params:=map{"source":"Not available"};

let $h:=xslt:transform($xml,$xslt,$params)
return file:write("c:\tmp\aa.html",$h)
