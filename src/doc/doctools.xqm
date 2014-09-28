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
 : e.g "C:\Program Files (x86)\basex\etc\modules\"
 :)
declare variable $doc:basex-modules:=file:parent(db:system()/globaloptions/repopath)
                                    || "etc\modules\";
 
(:~
 : full file system path to 
 :)                                    
declare function uri($type as xs:string,
                $app as xs:string,
                $path as xs:string) as xs:string
{
  switch ($type)
  case "app" return app-uri($app,$path)
  case "static"  return static-uri($app,$path)
  case "basex" return $doc:basex-modules || $path
  case "repo" return file:parent(db:system()/globaloptions/repopath) || $path 
  default      return fn:error(xs:QName('doc:uri'),"bad type: " || $type)
};

(:~
 : list basex module file paths. used as an xqdoc source
 :)
 declare function basex-modules()
 {
 file:list($doc:basex-modules)!fn:concat($doc:basex-modules,.)
 };
 
(:~
 : return uri for $path in $app 
 : @param $app name of app e.g ."doc"
 : @param $path path
 : @return file based uri e.g "" 
 :)
declare function app-uri(
                $app as xs:string,
                $path as xs:string) as xs:string
{
    fn:resolve-uri(fn:concat("../",$app,"/",$path))
};

(:~
 : @return uri for $path in $app static files
 :)
declare function static-uri(
                $app as xs:string,
                $path as xs:string) as xs:string
{
    fn:resolve-uri(fn:concat("../static/",$app,"/",$path))
};

(:~
 : xqdoc as xml or html
 : @param $app name of the app e.g "doc"
 : @param $src path to the source an app uri
 :)
declare function xqdoc($type as xs:string,
                        $app as xs:string,
                        $path as xs:string,
                        $fmt as xs:string)
{
    let $uri:=uri($type,$app,$path)
    let $doc:=inspect:xqdoc($uri)
    let $r:=if($fmt="html") then 
               let $params:=map { "path" := $path,"app":=$app }
               return xslt:transform($doc,fn:resolve-uri("xqdoc.xsl"),$params)
           else $doc
    return $r       
};


(:~
 : html report for components referenced in package
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