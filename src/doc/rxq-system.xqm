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

declare namespace xqdoc="http://www.xqdoc.org/1.0";
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace eval = 'quodatum.eval' at "lib/eval.xqm";
import module namespace request = "http://exquery.org/ns/request";

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
function dr:listtasks()
{
   <json type="array"/>
};

(:~
 :  about a task
 :)
declare 
%output:method("json") 
%rest:GET %rest:path("/doc/task/{$task}")
 %rest:query-param("app", "{$app}","doc")
function dr:atask2($app as xs:string,$task as xs:string)
{
   <json type="object"/>
};

(:~
 :  run a task
 :@param task 
 :@param $mode "sync" "async"
 :)
declare
%updating  
%output:method("text") 
%rest:POST %rest:path("/doc/task/{$task}")
 %rest:query-param("mode", "{$mode}","sync")
 %rest:query-param("app", "{$app}","doc")
function dr:dotask2($app as xs:string,$task as xs:string,$mode as xs:string)
{
  let $_:=$mode=>fn:trace("mode")
  let $base:=dr:get-base("doc")
   let $xq:=dr:get-task($task)  
   return (
            dr:task-log($app ,$task,$mode),
            if($mode="sync") then
               ( eval:update($xq,$base,map{}),
                 db:output("[success] task " || $task))
            else 
               let $j:= jobs:eval($xq,map{},map{"base-uri":$base,"cache":fn:true()}) 
               return db:output("[success] async " || $j) 
            )
};

(:~
 : run task
 : @param $mode "sync" or "async"
 :)
declare %updating function dr:task-log($app as xs:string,$task as xs:string,$mode as xs:string)
as empty-sequence()
{
    if(fn:doc-available("doc-doc/history.xml")) then
        let $history:=fn:doc("doc-doc/history.xml")/history
        let $event:=<event id="{1+$history/@nextId}" when="{fn:current-dateTime()}" app="{$app}">
                        <task name="{$task}" mode="{$mode}"/>
                   </event>
        return (insert node $event into $history,
                replace value of node $history/@nextId with 1+$history/@nextId)
    else
      ()
};

declare function dr:get-base($app as xs:string)
{
 let $w:=file:path-to-uri(db:system()/globaloptions/webpath)
 return $w || $app || "/tasks/file"
};

(:~ xquery src for name :)
declare function dr:get-task($name) 
as xs:string
{
  let $f:=fn:resolve-uri("tasks/" || $name )
  let $xq:= fn:unparsed-text($f)
  return $xq 
};


(:~
 :  ping incr counter
 :)
declare %updating  
%rest:POST %rest:path("/doc/ping")
%output:method("text")
function dr:dopost()
{
    (replace value of node $dr:state/hits with 1+$dr:state/hits,
            db:output(1+$dr:state/hits))
};

(:~
 :  ping incr counter
 :)
declare 
%output:method("text")  
%rest:GET %rest:path("/doc/ping")
function dr:dostate()
{
  $dr:state/hits
};

(:~ 
 :all task names
 :)
declare function dr:tasks()
{
    for $t in $dr:tasks
    let $name:=$t/xqdoc:module/xqdoc:uri
    order by $name
    return $name
};