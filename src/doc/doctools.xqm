xquery version "3.0";
(:~
: xqdoc utils
:
: @author andy bunce
: @since may 2014
: @licence apache 2
:)
 
module namespace doc = 'quodatum.doc';
declare default function namespace 'quodatum.doc';
declare namespace wadl="http://wadl.dev.java.net/2009/02";
declare namespace pkg="http://expath.org/ns/pkg";

import module namespace web = 'quodatum.web.utils2' at 'lib/webutils2.xqm';
import module namespace rest = 'http://exquery.org/ns/restxq';

declare variable $doc:components:=fn:doc("data/components.xml")/components;

(:~
 : return uri for $path in $app
 :)
declare function app-uri(
                $app as xs:string,
                $path as xs:string) as xs:string
{
    fn:resolve-uri(fn:concat("../",$app,"/",$path))
};

(:~
 : return uri for $path in $app static files
 :)
declare function static-uri(
                $app as xs:string,
                $path as xs:string) as xs:string
{
    fn:resolve-uri(fn:concat("../static/",$app,"/",$path))
};

declare function xquery-html($inspect)
{
    xslt:transform($inspect,fn:resolve-uri("xqdoc.xsl"))
};


(:~
 : html report for compoents referenced in package
 :)
declare function components-html($pkg as element())
{
    xslt:transform($pkg,fn:doc("component.xsl"))  
};


(:~
 : return html report for entries starting with $root
 :)
declare function wadl-html($root)
{
    let $doc:=wadl-under($root)
    let $params:=map { "root" := $root }
    return xslt:transform($doc,fn:resolve-uri("wadl.xsl"),$params)
};

(:~
 : wadl entries with paths starting at root
 :)
declare function wadl-under($root)
{
    copy $s:=rest:wadl()
    modify(
           delete node $s//wadl:resource[fn:not(fn:starts-with(@path,$root))] 
        )
    return $s
};