# tasks
Are Xquery updating expressions that create or update databases. 
They use the namespace "https://github.com/Quodatum/app-doc/task"

* `rxq-system` has restxq code

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

* `lib/eval.xqm` has eval code

````
declare  %updating function update($xq as xs:string,$base as xs:string,$options as map(*))
````

## definition
task list is taken to be any xqdoc:xqdoc documents that are:

1. type="main"
2. define the namespace https://github.com/Quodatum/app-doc/task

to initialise run task `load-app-code.xq`

