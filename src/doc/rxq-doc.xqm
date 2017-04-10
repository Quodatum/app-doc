(:~ 
 : A RESTXQ interface for documentation
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace dr = 'quodatum.doc.rest';
declare default function namespace 'quodatum.doc.rest';

import module namespace cmpx="quodatum.cmpx";
import module namespace cnf = 'quodatum.app.config' at 'config.xqm';
import module namespace doc = 'quodatum.doc' at 'doctools.xqm';
import module namespace txq = 'quodatum.txq' at "lib/txq.xqm";
import module namespace dice = 'quodatum.web.dice/v3' at "lib/dice.xqm";
import module namespace web = 'quodatum.web.utils4' at 'lib/webutils.xqm';
import module namespace entity = 'quodatum.models.generated' at 'generated/models.xqm';
import module namespace  qsr = 'quodatum.system.rest' at 'rxq-system.xqm';
import module namespace apps = 'quodatum.doc.apps' at "apps.xqm";

import module namespace df = 'quodatum.doc.file' at "lib/files.xqm";
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace request = "http://exquery.org/ns/request";

(:~
 : The doc home page as html. The UI entry point.
 :)
declare  
 %rest:GET %rest:path("doc")
 %output:method("html")
%output:media-type('text/html')
 %output:version("5.0")
function doc(){
     (: update model.xqm :)
     let $_:=fn:trace(fn:current-dateTime(),"*** START: ")
     let $_:=rest:init()
     (: @TODO check db exist app status et :)                 
     return if(db:exists("doc-doc") )
            then render("main.xq",map{})
            else <rest:forward>/doc/init</rest:forward>
};

(:~
 : Initialise/repair system by runnning tasks 1-3
 :)
declare %updating 
 %rest:GET %rest:path("doc/init")
 %output:method("html")
 %output:version("5.0")
 %output:media-type('text/html')
function doc-init(){
     (: update model.xqm  :)
     if(db:exists("doc-doc")) then (
         cnf:write-log("load-app-code~~~~~~~~~~~"),
         qsr:dotask2("doc","load-app-xqdoc.xq","sync"),
         cnf:write-log("~~~~~~run tasks"),
         wadl-save(),
         db:output(<rest:forward>/doc</rest:forward>)
         
     )else (
         cnf:write-log("~~~~~~create db"),
         qsr:dotask2("doc","generate-app-db.xq","sync"),
         db:output(<rest:forward>/doc/init</rest:forward>) 
     )
}; 

declare 
%updating
function wadl-save(){
    let $doc:=copy $c := rest:wadl()
              modify (insert node (attribute when {fn:current-dateTime()}) into  $c)
              return $c
    return db:replace("doc-doc","wadl.xml",$doc)
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
    let $entity:=$entity:list("app")
    let $searchs:=df:apps() ! apps:app-json(.,doc:uri#3)         
    let $searchs:=if($q) then fn:filter($searchs,$entity?filter(?,$q)) else $searchs                    
         
    let $_:= dice:response($searchs,$entity,web:dice())
    return $_
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
    
    let $item:=apps:app-json($app,doc:uri#3)
    return <json type="object">{dice:json-flds($item,$jsonf)/*}</json>
};

(:~
 : detail of app found on file system.
 :)
declare
%rest:GET %rest:path("doc/data/app/{$app}/component")
%rest:query-param("q", "{$q}") 
%output:method("json")   
function appcmp($app,$q) 
{
    let $data:=cmpx:app-dependents($app)!cmpx:status(.)
    let $entity:=$entity:list("component.version")
    return dice:response($data,$entity,web:dice())
};

(:~
 : detail of a task .
 :)
declare
%rest:GET %rest:path("doc/data/task/{$task}")
%output:method("json")   
function task($task) 
{
    let $entity:=$entity:list("task")
    let $items:=$entity?data()
    let $f:=$entity?access?name
    let $item:=$items[$f(.)=$task]
     (: just one :)
     return <json objects="json">{dice:json-flds($item,$entity?json)/*}</json>
 };


 
(:~
 : default entity lister
 :)
declare
%rest:GET %rest:path("doc/data/{$entity}")
%rest:query-param("q", "{$q}") 
%output:method("json") 
function entity-data($entity as xs:string,$q ) 
{
    let $entity:=$entity:list($entity)
    let $results:=$entity("data")()
    let $results:=if($q) then fn:filter($results,$entity?filter(?,$q)) else $results 
    (: parameter names that are entity fields :)
    let $p:=request:parameter-names()[.=map:keys($entity?access)]=>fn:trace("Xparams")
    let $p:=$p!map:entry(.,request:parameter(.))
    let $results:=fn:fold-left($p,$results,filter-fold($entity,?,?))
    return dice:response($results,$entity,web:dice())
};

declare function filter-fold($entity,$results,$next){
    let $a:=fn:trace($next,"filter-fold")
    let $name:=map:keys($next)
    let $test:=function($item){$entity?access($name)($item)=map:get($next,$name)}
    return fn:filter($results,$test)
};

(: ** DEBUG ** :)
declare
%rest:GET %rest:path("doc/data/test")
%rest:query-param("q", "{$q}") 

function test-data($q ) 
{
    let $entity:=$entity:list("xqmodule")
    let $results:=fn:doc(fn:resolve-uri("test-xml.xml"))/*/*
    
    return dice:response($results,$entity)
};

(:~
 : xqmodule xqdoc item lister
 :)
declare
%rest:GET %rest:path("doc/data/xqmodule/xqdoc")
%output:method("xml")
%rest:query-param("item", "{$item}")
%rest:query-param("view", "{$view}","json")    
function xqmodule-xqdoc(
    $item as xs:string,
    $view as xs:string
){
    let $doc:=fn:doc("/doc-doc/" || $item)
    return $doc
};

(:~
 : xqmodule xqdoc item lister
 :)
declare
%rest:GET %rest:path("doc/data/xqmodule/parse")
%output:method("xml")
%rest:query-param("item", "{$item}")
%rest:query-param("view", "{$view}","json")    
function xqmodule-parse(
    $item as xs:string,
    $view as xs:string
){
    let $doc:=fn:doc("/doc-doc/parse/" || $item || ".xqdoc")
    return $doc
};

(:~
 : xqmodule xqdoc item lister
 :)
declare
%rest:GET %rest:path("doc/data/xqmodule/xq")
%output:method("text")
%rest:query-param("item", "{$item}")
%rest:query-param("view", "{$view}","json")    
function xqmodule-xq(
    $item as xs:string,
    $view as xs:string
){
    let $_:=fn:trace($item,"iiiiii")
    let $entity:=$entity:list("xqmodule")
    let $results:=$entity("data")()
    let $results:=$results[$item=$entity?access?dbpath(.)]
    return $entity?access?srcpath($results)=>df:webpath()=>file:read-text()
};
(:~
 : xqmodule data item lister
 :)
declare
%rest:GET %rest:path("doc/data/xqmodule/item")
%output:method("json")
%rest:query-param("item", "{$item}")
%rest:query-param("view", "{$view}","json")    
function xqmodule-item(
    $item as xs:string,
    $view as xs:string
){
    let $view:=$view=>fn:trace("view")
    let $entity:=$entity:list("xqmodule")
    let $results:=$entity("data")()
    let $results:=$results[$item=$entity?access?dbpath(.)]
    return if($results)
            then dice:one(fn:head($results),$entity)
            else fn:error()
};

(:~
 : default data item lister
 :)
declare
%rest:GET %rest:path("doc/data/{$entity}/{$name}")
%output:method("json")   
function data-item($entity as xs:string,$name as xs:string ) 
{

    let $entity:=$entity:list($entity)
    let $result:=dice:get($entity,$name)
    let $_:=fn:trace($result,"$$$$$")
    return dice:one($result,$entity)

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
    return dice:response($results,$entity,web:dice())
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
              return doc:component-render($fmt,$doc)
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
    doc:component-render($fmt)
    
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
    let $entity:=$entity:list("xqmodule")

    let $items:=$entity?data()
  
    let $_:= dice:response($items,$entity,web:dice())
    return $_
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
                  
    let $errs:=if(fn:not(fn:doc-available($xml)))
               then "xml not found:" || $xml
               else if (fn:not(fn:doc-available($schema)))
                    then "schema not found:" || $schema
                    else validate:xsd-info(fn:doc($xml), fn:doc($schema))
    return <json type="array">{$errs!<_>{.}</_>}</json>   
};

(:~
 :  status info json
 :)
declare 
%output:method("json") 
%rest:GET %rest:path("/doc/status")
function status(){
   <json type="object">
   <version>{cnf:settings()?version}</version>
   <cacherestxq>{db:system()/globaloptions/cacherestxq/fn:string()}</cacherestxq>
   </json>
};

(:~
 : html rendering
 :) 
declare function render($template,$map){
    let $defaults:=cnf:settings()
    let $map:=map:merge(($defaults,$map))
    return (web:method("html"),txq:render(
                fn:resolve-uri("./templates/" || $template)
                ,$map
                ,fn:resolve-uri("./templates/layout.xq")
                )
            )
};

