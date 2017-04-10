(:~
 : Update `generated/models.xqm` from files in `data/models`
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 :)

declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace bf = 'quodatum.tools.buildfields' at "../lib/entity-gen.xqm";
  
let $efolder:="file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models"
let $target:="file:///C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"
return (bf:write($efolder,$target),db:output("generated C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"))
          
