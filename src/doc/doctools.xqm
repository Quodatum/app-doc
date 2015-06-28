xquery version "3.0";
(:~
: manage documentation metadata and generation
:
: @copyright quodatum ltd
: @author andy bunce
: @since may 2014
: @licence apache 2
:)
 
module namespace doc = 'quodatum.doc';
declare default function namespace 'quodatum.doc';
declare namespace wadl="http://wadl.dev.java.net/2009/02";
declare namespace pkg="http://expath.org/ns/pkg";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

declare variable $doc:components:=fn:doc("data/doc/components.xml")/components;

declare variable $doc:repopath:=file:parent(db:system()/globaloptions/repopath);
(:~ 
 : e.g "C:\Program Files (x86)\basex\etc\modules\"
 :)
declare variable $doc:basex-modules:=db:list("doc-doc","basex.xqm");
 
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
  case "basex" return  $path
  case "repo" return $doc:repopath || $path 
  default      return fn:error(xs:QName('doc:uri'),"bad type: " || $type)
};

(:~
 : list basex module file paths. used as an xqdoc source
 :)
 declare function basex-modules() as xs:string*
 {
  for $name in $doc:basex-modules!fn:substring-after(.,"/")
  order by $name
  return $name
 };
 
(:~
 :  xqdoc for a basex system module 
  : @param $source file name for module e.g admin.xqm
 :)
 declare function basex-xqdoc($module as xs:string) as element(xqdoc:xqdoc)
 {
  db:open("doc-doc","basex.xqm/" || $module)/xqdoc:xqdoc
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
 : @param $path path to the source an app uri
 :)
declare function xqdoc($type as xs:string,
                        $path as xs:string)
as element(xqdoc:xqdoc){
        let $doc:=if($type="basex") then basex-xqdoc($path) 
                      else xqdoc_($path)
        return copy $c := $doc
                modify (
                  for $d in $c//xqdoc:description
                  return replace node $d with <xqdoc:description>{fn:parse-xml-fragment($d)}</xqdoc:description>
                   )
                 return $c                            
};

declare function xqdoc_($path as xs:string){
    try{
        inspect:xqdoc($path)
    } catch * {
     <xqdoc:xqdoc type="err">{$path}</xqdoc:xqdoc>
    }
};

(:~
 : html report for components referenced in package
 :)
declare function components-html($pkg as element())
{
    xslt:transform($pkg,"xslt/component.xsl")  
};

(:~
 : svg graph for components referenced in package
 :)
declare function components-svg($pkg as element())
{
    xslt:transform($pkg,"xslt/component.xsl")  
};

(:~
 : return html report for WADL entries supplied
 : @param $root leading path segment to be dropped  from report
 :)
declare function wadl-html($wadl,$root as xs:string)
{
    let $params:=map { "root" : $root }
    return xslt:transform($wadl,"xslt/wadl.xsl",$params)
};

(:~
 : wadl entries with paths starting at root
 :)
declare function wadl-under($wadl as element(wadl:application),
                            $root as xs:string) as element(wadl:application)
{
 copy $s:=$wadl
   modify(
           delete node $s//wadl:resource[fn:not(
                                fn:starts-with(@path,$root) or fn:starts-with( @path,"/" || $root)
                                )]  (: @TODO regx :)
        )  
    return $s
};

declare function templates($app as xs:string){
    let $path:= static-uri($app,"templates/")
    
    let $list:=file:list($path,fn:true())
    let $_:=fn:trace($list,"path::::")
return $list
};