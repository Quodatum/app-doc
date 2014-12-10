(: task run functions 
 : hand generated 
 :)

module namespace tasks = 'quodatum.tasks.generated';
declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace bf = 'quodatum.tools.buildfields' at "../lib/entity-gen.xqm";
import module namespace dbtools = 'quodatum.dbtools'  at "../lib/dbtools.xqm";

declare variable $tasks:base-uri:=fn:resolve-uri("../");
 
declare %updating function tasks:task($index){
 switch ($index) 
   case "1" return tasks:task1()
   case "2" return tasks:task2()
   case "3" return tasks:task3()
   default return db:output("Unknown task")
};
 
(:~
 : Update models.xqm" from data/models
 :)
declare 
%updating
%task:name("task1")
 function tasks:task1(){
    let $efolder:=fn:resolve-uri("./data/doc/models",$tasks:base-uri)
    return 
        bf:write(
                $efolder,
                fn:resolve-uri("generated/models.xqm",$tasks:base-uri)
                )
};         

(:~
 :  Create or update database "doc-data" from files in the folder data/doc 
 :)
declare 
%updating
%task:name("task2")
 function tasks:task2(){
  let $app:="doc"
  let $db:="doc-data" 
  let $src:=$dbtools:webpath ||$app || "/data/doc"
  return dbtools:sync-from-path($db,$src)
   
};         

(:~
 :  nothing  yet
 :)
declare 
%updating
%task:name("task3")
 function tasks:task3(){
  let $app:="doc"
  return db:output("nothing yet")
   
};   