(: task run functions 
 : hand generated 
 :)

module namespace tasks = 'quodatum.tasks.generated';
declare base-uri "../";
import module namespace bf = 'quodatum.tools.buildfields' at "lib/entity-gen.xqm";
import module namespace dbtools = 'quodatum.dbtools'  at "lib/dbtools.xqm";
 
declare %updating function tasks:task($index){
 switch ($index) 
   case "1" return tasks:task1()
   case "2" return tasks:task2()
   default return db:output("Unknown task")
};
 
declare %updating function tasks:task1(){
    let $efolder:=fn:resolve-uri("./data/models")
    return (
        bf:write($efolder,fn:resolve-uri("generated/models.xqm")),
        db:output("models.xqm updated")
    )
};         

declare %updating function tasks:task2(){
  let $app:="doc"
  let $db:="doc-data" 
  let $src:=$dbtools:webpath ||$app || "/data/"
  return (db:output("ok"),
         dbtools:sync-from-path($db,$src)
         )
};         
  