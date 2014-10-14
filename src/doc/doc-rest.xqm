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
import module namespace entity = 'quodatum.models.generated' at 'models.xqm';
import module namespace cva = 'quodatum.cva.rest' at "lib/cva.xqm";
import module namespace df = 'quodatum.doc.file' at "lib/files.xqm";
import module namespace eval = 'quodatum.eval' at "lib/eval.xqm";
import module namespace bf = 'quodatum.tools.buildfields' at "lib/entity-gen.xqm";


(:~
 : The doc home page as html. The UI entry point.
 :)
declare
 %rest:GET %rest:path("doc")
 %output:method("html")
 %output:version("5.0")
function doc(){
     (: update model.xqm :)
     let $tasks:=fn:doc("data/tasks.xml")
     
     let $x:=bf:write(fn:resolve-uri("./data/models"),
                      fn:resolve-uri("models.xqm"))
     (: @TODO check db exist app status et :)                 
     return render("main.xq",map{})
}; 

declare
%unit:test
function test-gen(){
    bf:write(fn:resolve-uri("./data/models"), fn:resolve-uri("models.xqm"))
};

(:~
 : List of apps found on file system.
 :)
declare
%rest:GET %rest:path("doc/data/app")
%output:method("json")   
function app() 
{
let $items:=for $a in df:apps()
            order by $a
            return <item>
                    <name>{$a}</name>
                    <description>sss</description>
                    </item>

let $flds:=entity:fields("application")

return dice:json-request($items,$flds)
};

(:~
 : list of direct children of $path as json array
 : @param $path eg "/app"  
 : @return json [ {name:"gg","path:"aaa/bb",isdir:false},{}..]
 :)
declare
%rest:GET %rest:path("doc/data/file/list")
%rest:query-param("path", "{$path}","/")  
%output:method("json")   
function files($path) as element(json) 
{
    <json type="array">{df:list($path)}</json>
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
function search() 
{
    let $items:=(<item><name>doc</name></item>,
                <item><name>benchx</name></item>)
    let $flds:=entity:fields("application")
    return dice:json-request($items,$flds)
};

(:~
 : show xqdoc for $path in $app
 : @param fmt: 'xml' or 'html'
 :)
declare 
%rest:GET %rest:path("doc/app/{$app}/server/xqdoc")
%restxq:query-param("path", "{$path}","")
%restxq:query-param("fmt", "{$fmt}","html")
%restxq:query-param("type", "{$type}")   
function xqdoc($type ,
                $app as xs:string,
                $path as xs:string,
                $fmt as xs:string) 
{
    let $type:=($type,"app")[1]
    let $uri:=doc:uri($type,$app,$path)
    let $_:=fn:trace(($type,$app,$path),"uri: ")
    return if(fn:unparsed-text-available($uri))
           then
                let $r:=doc:xqdoc($type,$app,$path,$fmt)
                return (web:method($fmt),$r)
           else
             <div> 
               <div>'{$uri}' not found
               <a href="#apps/{$app}/xqdoc?path=benchx-rest.xqm">bench-rest.xqm</a>
               <a href="#apps/{$app}/xqdoc?path=doc-rest.xqm">doc-rest.xqm</a>
               <a href="#apps/{$app}/xqdoc?type=basex&amp;path=file.xqm">files.xqm</a>
               </div>
               <filepick value="fred" endpoint="data/file/list"/>   
               </div> 
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
  let $s:="expath-pkg.xml"
  let $pkg:=doc:app-uri($app,$s)
  return if (fn:not(fn:doc-available($pkg)))
         then fn:error(xs:QName('dr:package'),$pkg || " not found")
         else let $doc:=fn:doc($pkg) 
              return if($fmt="xml") 
                      then (web:download-response("xml", $s),$doc)
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
     
      return <div>
      
      <iframe src="/static/{$app}/templates/{$t}">zz</iframe>
      <a href="/static/{$app}/templates/{$t}">{$t}</a>
      </div>
      }</div>
}; 

(:~
 : list all components in catalog
 : @param $fmt "xml" or "html"
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

(:~
 : get xquery documentation 
 :)
declare 
%rest:GET %rest:path("doc/xqdoc")
%restxq:query-param("path", "{$path}","")
%restxq:query-param("fmt", "{$fmt}","html")
%restxq:query-param("type", "{$type}","basex")   
function basex-modules($path as xs:string,
                        $fmt as xs:string,
                        $type as xs:string){
    xqdoc($type,"",$path,$fmt)
    
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
 : @return bar as json
 :)
declare
%rest:GET %rest:path("doc/meta/cvabar/{$bar}")
%output:method("json")
function bar($bar){
    cva:getbar("doc",$bar)
};

(:~
 : html rendering
 :) 
declare function render($template,$map){
    let $defaults:=map{
                        "version":"0.4.0",
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

