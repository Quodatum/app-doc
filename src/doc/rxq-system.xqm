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

import module namespace df = 'quodatum.doc.file' at "lib/files.xqm";
import module namespace eval = 'quodatum.eval' at "lib/eval.xqm";

declare variable $dr:state as element(state):=db:open("doc-data","/state.xml")/state;

(:~
 :  run a task
 :)
declare  
%output:method("text")  
%rest:POST %rest:path("{$app}/task2/{$task}")
function dotask2($app,$task){
   let $xq:=get-task($task)  
   return eval:update($xq,get-base($app),5)
};

declare function get-base($app as xs:string){
 let $w:=file:path-to-uri(db:system()/globaloptions/webpath)
 return $w || $app || "/tasks/file"
};

declare function get-task($name){
  let $f:=fn:resolve-uri("tasks/task" || $name || ".xq")
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

