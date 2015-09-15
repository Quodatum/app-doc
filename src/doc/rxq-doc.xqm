(:~ 
 : A RESTXQ interface for documentation
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace dr = 'quodatum.doc.rest';
declare default function namespace 'quodatum.doc.rest';
declare namespace cxan="http://cxan.org/ns/package";

import module namespace cnf = 'quodatum.app.config' at 'config.xqm';
import module namespace doc = 'quodatum.doc' at 'doctools.xqm';
import module namespace txq = 'quodatum.txq' at "lib/txq.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at 'lib/webutils.xqm';
import module namespace entity = 'quodatum.models.generated' at 'generated/models.xqm';
import module namespace  qsr = 'quodatum.system.rest' at 'rxq-system.xqm';

import module namespace df = 'quodatum.doc.file' at "lib/files.xqm";
import module namespace rest = "http://exquery.org/ns/restxq";


(:~
 : The doc home page as html. The UI entry point.
 :)
declare  
 %rest:GET %rest:path("doc")
 %output:method("html")
 %output:version("5.0")
function doc(){
     (: update model.xqm :)
     let $_:=fn:trace(fn:current-dateTime(),"*** START: ")
     (: @TODO check db exist app status et :)                 
     return if(db:exists("doc-doc") )
            then render("main.xq",map{})
            else <rest:forward>/doc/init</rest:forward>
};

(:~
 : Initialise system by runnning tasks 1-3
 :)
declare %updating 
 %rest:GET %rest:path("doc/init")
 %output:method("html")
 %output:version("5.0")
function doc-init(){
     (: update model.xqm  :)
     if(db:exists("doc-doc")) then (
         cnf:write-log("load-app-code~~~~~~~~~~~"),
         qsr:dotask2("doc","load-app-code.xq"),
         cnf:write-log("~~~~~~run tasks"),
         db:output(<rest:forward>/doc</rest:forward>)
         
     )else (
         cnf:write-log("~~~~~~create db"),
         qsr:dotask2("doc","generate-app-db.xq"),
         db:output(<rest:forward>/doc/init</rest:forward>) 
     )
}; 


(:~
 : List of apps found on file system.
 :)
declare
%rest:GET %rest:path("doc/data/app")
%rest:query-param("q", "{$q}")  
%output:method("json")
function apps($q ) 
{

let $searchs:=df:apps()! app-json(.)
            
let $searchs:=if($q) then filter-apps($searchs,$q) else $searchs                    
let $entity:=$entity:list("app")
let $_:= dice:response($searchs,$entity)
return fn:trace($_,"json")
};

declare function filter-apps($apps as element()*,$q as xs:string){
 $apps[some $e in (name,description)satisfies  fn:contains($e,$q)]
};

(:~ 
 :detail of app
 :)
declare function app-json($app as xs:string) as element(item){
    let $cxan:=doc:uri("app",$app,"cxan.xml")
    let $logo:=doc:uri("static",$app,"logo.svg")
    let $logo:= if(file:exists($logo))
                then <logo>{"/static/" || $app || "/logo.svg"}</logo> 
                else <logo>{"/static/" || "doc" || "/nologo.svg"}</logo> 
    let $desc:=if(fn:doc-available($cxan)) 
               then fn:doc($cxan)/cxan:package/cxan:abstract/fn:string()
               else "(no cxan.xml)"        
     return <item type="object">
                    <name>{$app}</name>
                    <description>{$desc}</description>
                    {$logo
                    }</item>            
};


(:~
 : detail of app found on file system.
 :)
declare
%rest:GET %rest:path("doc/data/app/{$app}")
%output:method("json")   
function app($app) 
{
    let $entity:=$entity:list("app")
    let $jsonf:= map:get($entity,"json")
    
    let $item:=app-json($app)
    return <json type="object">{dice:json-flds($item,$jsonf)/*}</json>
};

(:~
 : detail of a task .
 :)
declare
%rest:GET %rest:path("doc/data/task/{$task}")
%output:method("json")   
function task($task) 
{
    <json type="object"><name>{$task}</name></json>
};
(:~
 : default entity lister
 :)
declare
%rest:GET %rest:path("doc/data/{$entity}")
%output:method("json")   
function entity-data($entity as xs:string) 
{
    let $entity:=$entity:list($entity)
    let $results:=$entity("data")()
    let $_:=fn:trace($results,"entity RESULTS ")
    return dice:response($results,$entity)
};

(:~
 : list of direct children of $path as json array
 : @param $path path to list the children of eg "/app"  
 : @return json [ {name:"gg","path:"aaa/bb",isdir:false},{}..]
 :)
declare
%rest:GET %rest:path("doc/data/file/list")
%rest:query-param("path", "{$path}","/")
%rest:query-param("search", "{$search}","")    
%output:method("json")   
function files($path,$search) as element(json) 
{
    if(fn:normalize-space($search))
    then   <json type="array">{df:find("/",$search)}</json> 
    else <json type="array">{df:list($path)}</json>
};

(:~
 : list of files matching pattern as json array
 : @param $path eg "/app"  
 : @return json [ {name:"gg","path:"aaa/bb",isdir:false},{}..]
 :)
declare
%rest:GET %rest:path("doc/data/file/find")
%rest:query-param("pattern", "{$pattern}","") 
%output:method("json")   
function find($pattern) as element(json) 
{
    <json type="array">{df:find("/",$pattern)}</json>
};

(:~
 : get contents of file.
 : @param $path e.g. "/app/doc/readme.md"
 : @return html resprestation of file
 :)
declare
%rest:GET %rest:path("doc/data/file/read")
%rest:query-param("path", "{$path}","/")  
%output:method("html")   
function read($path) as element() 
{
    <pre>{df:read($path)}</pre>
};

(:~
 : search apps
 : @TODO fix this
 :)
declare
%rest:GET %rest:path("doc/search")
%output:method("json") 
%rest:query-param("q", "{$q}")  
function search($q) 
{
    let $results:=(<search>
                <title>searching for {$q}</title>
                <uri>/apps/doc</uri>
                </search>,
                <search>
                <title>benchx</title>
                <uri>/apps/benchx</uri>
            </search>)
    let $entity:=$entity:list("search-result")
    return dice:response($results,$entity)
};

(:~
 : show xqdoc for $path in $app
 : @param fmt: 'xml' or 'html'
 : @param path:  eg 'admin.xqm'
  : @param type:  eg 'app' 'static' 'basex' 'repo'
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/view/xqdoc")
%restxq:query-param("path", "{$path}","")
%restxq:query-param("fmt", "{$fmt}","html")
%restxq:query-param("type", "{$type}","app")   
function xqdoc($type as xs:string,
                $app as xs:string,
                $path as xs:string,
                $fmt as xs:string) 
{
    let $uri:=doc:uri($type,$app,$path)
    let $_:=fn:trace(($type,$app,$path),"uri: ")
    return 
                let $r:=doc:xqdoc($type,$uri)
                return (web:method($fmt),$r)
           
};

(:~
 : show xqdoc for rest api 
 : @TODO permission
 :)
declare 
%rest:GET %rest:path("doc/wadl")
%output:method("html")
%restxq:query-param("fmt", "{$fmt}","html")  
function wadl-full(
              $fmt as xs:string) 
{
  let $w:=doc:wadl-under(rest:wadl(), "")
  let $r:=if($fmt="html")then doc:wadl-html($w,"/" ) else $w
  return (web:method($fmt),$r) 
}; 
 
(:~
 : show xqdoc for rest api
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/view/wadl")
%output:method("html")
%restxq:query-param("path", "{$path}","")
%restxq:query-param("fmt", "{$fmt}","html")  
function wadl($app as xs:string,
              $path as xs:string,
              $fmt as xs:string) 
{
  let $w:=doc:wadl-under(rest:wadl(), $app)
  let $r:=if($fmt="html")then doc:wadl-html($w,"/" || $app) else $w
  return (web:method($fmt),$r) 
}; 

(:~
 : show client  components from the package.xml
 : @parameter $fmt xml or html
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/view/component")
%restxq:query-param("fmt", "{$fmt}","html")
%output:method("html")  
function client-components($app as xs:string,
                        $fmt as xs:string) 
{
  let $pkg:=doc:app-uri($app,"expath-pkg.xml")
  return if (fn:doc-available($pkg))
         then let $doc:=fn:doc($pkg)/* 
              return doc:component-render($doc,$fmt)
         else <div>"expath-pkg.xml" not found.)</div>   
}; 

(:~
 : show list templates
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/view/template")
%output:method("json")  
function templates($app as xs:string) 
{
   <json type="array">{
     for $t in doc:templates($app)
     let $path:=doc:static-uri($app,"templates/") || $t
     order by fn:lower-case($t)
     
      return <_ type="object">
      <name>{$t}</name>
      <path>/static/{$app}/templates/{$t}</path>
      <src>{file:read-text($path)}</src>
      </_>
      }</json>
}; 

(:~
 : list all components in catalog
 : @param $fmt "xml" or "html"
 :)
declare 
%rest:GET %rest:path("doc/components/browser")
%output:method("html") 
%restxq:query-param("fmt", "{$fmt}","html")
function browser-list($fmt as xs:string){
    let $d:=$doc:components
    return doc:component-render($d,$fmt)
    
};

(:~
 : names of builtin basex xquery modules
 : @param $fmt "xml" or "html"
 :)
declare 
%rest:GET %rest:path("doc/components/basex")
%output:method("json")
function basex-list()
{
<json type="array">{
   doc:basex-modules()!<_>{.}</_>
   }</json>
};


(:~
 : get xquery documentation for $path and $type
 :)
declare 
%rest:GET %rest:path("doc/xqdoc")
%restxq:query-param("path", "{$path}","")
%restxq:query-param("fmt", "{$fmt}","html")
%restxq:query-param("type", "{$type}","basex")   
function xq-modules($path as xs:string,
                    $fmt as xs:string,
                    $type as xs:string)
{
    
    let $xqdoc:=doc:xqdoc( $type ,$path)
    let $r:=if($fmt="html") then 
               let $params:=map { "path" : $path,"app":"none" }
               return xslt:transform($xqdoc,fn:resolve-uri("xslt/xqdoc.xsl"),$params)
           else $xqdoc
    return (web:method($fmt),$r) 
};

(:~
 : validate server xml against server xsd
 :)
declare 
%rest:GET %rest:path("doc/validate")
%restxq:query-param("xml", "{$xml}","")
%restxq:query-param("schema", "{$schema}","")
%output:method("json")  
function validate($xml as xs:string,
                  $schema as xs:string){
    let $xml:=df:webpath($xml)!fn:trace(.,"xml ")
    let $schema:=df:webpath($schema)!fn:trace(.,"xsd ")
                  
    let $errs:=validate:xsd-info(fn:doc($xml), fn:doc($schema))
    return <json type="array">{$errs!<_>{.}</_>}</json>   
};

(:~
 : html rendering
 :) 
declare function render($template,$map){
    let $defaults:=cnf:settings()
    let $map:=map:merge(($map,$defaults))
    return (web:method("html"),txq:render(
                fn:resolve-uri("./templates/" || $template)
                ,$map
                ,fn:resolve-uri("./templates/layout.xq")
                )
            )
};

