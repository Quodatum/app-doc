(:~ 
 : A RESTXQ interface for documentation
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace dr = 'quodatum.doc.rest';
declare default function namespace 'quodatum.doc.rest'; 

import module namespace doc = 'quodatum.doc' at 'doctools.xqm';
import module namespace txq = 'quodatum.txq' at "lib/txq.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "lib/dice.xqm";
import module namespace web = 'quodatum.web.utils2' at 'lib/webutils2.xqm';
import module namespace entity = 'apb.models.generated' at 'models.xqm';
import module namespace cva = 'quodatum.cva.rest' at "lib/cva.xqm";

(:  trailing slash :)
declare variable $dr:base:= db:system()/globaloptions/webpath/fn:string()
                             || file:dir-separator();

(:~ true path from segment :)
declare function path($path as xs:string)
 as xs:string{
 $dr:base || $path
};

(:~
 : The doc api
 :)
declare
 %rest:GET %rest:path("doc")
 %output:method("html")
 %output:version("5.0")
function doc(){
 (: @TODO check db exist app status et :)
 render("main.xq",map{})
}; 

(:~
 : list of apps
 :)
declare
%rest:GET %rest:path("doc/data/app")
%output:method("json")   
function app() 
{
let $items:=(<item><name>doc</name></item>,
            <item><name>benchx</name></item>)
let $flds:=entity:fields("application")

return dice:json-request($items,$flds)
};

(:~
 : list of files
 :)
declare
%rest:GET %rest:path("doc/data/files")
%rest:query-param("dir", "{$dir}","/")  
%output:method("json")   
function files($dir) as element(json) 
{
    let $fdir:= path($dir)
    let $xq:=file:list($fdir)
    let $f:=function($d,$isFolder){
             let $d:=fn:translate($d,"\","/")
             return   
              <_ type="object">
                 <name>{$d}</name>
                 <path>{$dir || $d}</path>
                 <isdir type="boolean">{$isFolder}</isdir>
              </_>}
    return 
    <json type="array">
      {for $d in $xq where file:is-dir($fdir ||$d)
         return $f($d,fn:true())
      }
      { for $d in $xq where fn:not(file:is-dir($fdir ||$d))
        return  $f($d,fn:false())
       }         
 </json>
};

(:~
 : search apps
 : @TODO fix this
 :)
declare
%rest:GET %rest:path("doc/search")
%output:method("json")   
function search() 
{
let $items:=(<item><name>doc</name></item>,
            <item><name>benchx</name></item>)
let $flds:=entity:fields("application")
return dice:json-request($items,$flds)
};

(:~
 : The doc $app api
 :)
declare
%rest:GET %rest:path("doc/app/{$app}") 
 %output:method("html")
 %output:version("5.0")
function app($app as xs:string) 
{
   <section>
       <h2><a href="..">doc</a>/{$app}</h2>
       <a href="{$app}/server/xqdoc">Xquery doc for application</a>
       <a href="{$app}/server/wadl">WADL doc for application</a>
       <a href="{$app}/client/components">Client side components used by the application</a>
       <a href="{$app}/client/templates">XML templates  for application</a>       
   </section>
};
(:~
 : show xqdoc for $mod in $app
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/server/xqdoc")
%restxq:query-param("mod", "{$mod}","benchx-rest.xqm")
%restxq:query-param("fmt", "{$fmt}","html")   
function xqdoc($app as xs:string,
                $mod as xs:string,
                $fmt as xs:string) 
{
    let $src:=doc:app-uri($app,$mod)
    let $mod:=fn:trace($mod,"mod::::")
    let $doc:=inspect:xqdoc($src)
    let $r:=if($fmt="html") then doc:xquery-html($doc) else $doc
    return (web:method($fmt),$r)
};


 
(:~
 : show xqdoc for rest api
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/server/wadl")
%output:method("html")  
function wadl($app as xs:string) 
{
  doc:wadl-html("/" || $app) 
}; 

(:~
 : show client  components from the package.xml
 : @parameter $fmt xml or html
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/client/components")
%restxq:query-param("fmt", "{$fmt}","html")
%output:method("html")  
function client-components($app as xs:string,
                        $fmt as xs:string) 
{
  let $pkg:=doc:app-uri($app,"package.xml")
  return if (fn:not(fn:doc-available($pkg)))
         then fn:error(xs:QName('dr:package'),"package.xml not found")
         else let $doc:=fn:doc($pkg) 
              return if($fmt="xml") 
                      then (web:download-response("xml", "package.xml"),$doc)
                      else doc:components-html($doc/*)    
}; 

(:~
 : show list templates
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/client/templates")
%output:method("html")  
function templates($app as xs:string) 
{
    let $path:=doc:static-uri($app,"templates/")
    let $path:=fn:trace($path,"path::::")
    let $list:=file:list($path,fn:true())
    return <div>{
     for $t in $list
     order by fn:lower-case($t)
      return <a href="/static/{$app}/templates/{$t}">{$t}</a>
      }</div>
}; 

(:~
 : list all components in catalog
 :)
declare 
%rest:GET %rest:path("doc/components")
%restxq:query-param("fmt", "{$fmt}","xml")
function components($fmt as xs:string){
    let $d:=$doc:components
    return (
        web:method($fmt),
        if($fmt="xml") then $d else doc:components-html($d)
    )
    
};

declare
%rest:GET %rest:path("doc/meta/cvabar/{$bar}")
%output:method("json")
function bar($bar){
    cva:getbar("doc",$bar)
};
 
declare function render($template,$map){
  let $defaults:=map{
                    "version":"0.2.0",
                    "static":"/static/doc/"
                }
let $map:=map:new(($map,$defaults))
return ($web:html5,txq:render(
            fn:resolve-uri("./templates/" || $template)
            ,$map
            ,fn:resolve-uri("./templates/layout.xq")
            )
        )
};

