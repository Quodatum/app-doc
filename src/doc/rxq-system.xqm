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

import module namespace dice = 'quodatum.web.dice/v2' at "lib/dice.xqm";
import module namespace eval = 'quodatum.eval' at "lib/eval.xqm";

declare variable $dr:state as element(state):=db:open("doc-doc","/state.xml")/state;

(:~
 :  list tasks
 :)
declare  
%output:method("json")  
%rest:GET %rest:path("{$app}/task")
function listtasks($app){
   <json type="array"/>
};
(:~
 :  run a task
 :)
declare  
%output:method("text")  
%rest:POST %rest:path("{$app}/task/{$task}")
function dotask2($app,$task){
   let $xq:=get-task($task)  
   let $r:= eval:update($xq,get-base($app),5)
   return $r
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
%rest:POST %rest:path("{$app}/ping")
function dopost($app){
    (replace value of node $dr:state/hits with 1+$dr:state/hits,
            db:output(1+$dr:state/hits))
};
(:~
 :  ping incr counter
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("{$app}/ping")
function dostate($app){
  $dr:state/hits
};

declare function tasks(){
db:open("doc-doc")//xqdoc:xqdoc[
  xqdoc:namespaces/xqdoc:namespace/@uri="https://github.com/Quodatum/app-doc/task"
 and xqdoc:module/@type="main"
] 
/xqdoc:module/xqdoc:uri
};