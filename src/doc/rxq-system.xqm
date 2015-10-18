(:~ 
 : A RESTXQ interface for common system functionality
 : includes tasks
 :
 :@copyright Quodatum Ltd
 :@license Apache 2
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace dr = 'quodatum.system.rest';
declare default function namespace 'quodatum.system.rest'; 
declare namespace xqdoc="http://www.xqdoc.org/1.0";

import module namespace eval = 'quodatum.eval' at "lib/eval.xqm";

declare variable $dr:db as xs:string:="doc-doc";

declare variable $dr:state as element(state):=db:open("doc-doc","/state.xml")/state;
declare variable $dr:tasks as element(xqdoc:xqdoc)*:=db:open("doc-doc")//xqdoc:xqdoc[
  xqdoc:namespaces/xqdoc:namespace/@uri="https://github.com/Quodatum/app-doc/task"
 and xqdoc:module/@type="main"
]; 


(:~
 :  list tasks
 :)
declare  
%rest:GET %rest:path("/doc/task")
%output:method("json") 
function listtasks(){
   <json type="array"/>
};

(:~
 :  about a task
 :)
declare 
%output:method("json") 
%rest:GET %rest:path("/doc/task/{$task}")
 %rest:query-param("app", "{$app}","doc")
function atask2($app as xs:string,$task as xs:string){
   <json type="object"/>
};

(:~
 :  run a task
 :)
declare
%updating  
%output:method("text") 
%rest:POST %rest:path("/doc/task/{$task}")
 %rest:query-param("app", "{$app}","doc")
function dotask2($app as xs:string,$task as xs:string){
   let $xq:=get-task($task)  
   return( eval:update($xq,get-base("doc"),map{}), db:output("ok-top"))
};

declare function get-base($app as xs:string){
 let $w:=file:path-to-uri(db:system()/globaloptions/webpath)
 return $w || $app || "/tasks/file"
};

(:~ xquery src for name :)
declare function get-task($name) as xs:string{
  let $f:=fn:resolve-uri("tasks/" || $name )
  let $xq:= fn:unparsed-text($f)
  return $xq 
};

(:~
 :  ping incr counter
 :)
declare %updating
%output:method("text")  
%rest:POST %rest:path("/doc/ping")
function dopost(){
    (replace value of node $dr:state/hits with 1+$dr:state/hits,
            db:output(1+$dr:state/hits))
};
(:~
 :  ping incr counter
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/doc/ping")
function dostate(){
  $dr:state/hits
};

(:~ 
 :all task names
 :)
declare function tasks(){
    for $t in $dr:tasks
    let $name:=$t/xqdoc:module/xqdoc:uri
    order by $name
    return $name
};