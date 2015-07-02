(:~
 : Create or update database "doc-doc" from files in the folder data/doc 
 :)

declare namespace task="https://github.com/Quodatum/app-doc/task";

import module namespace dbtools = 'quodatum.dbtools'  at "../lib/dbtools.xqm";
import module namespace doc = 'quodatum.doc' at "../doctools.xqm";
declare option db:inlinelimit '0';

declare function task:ingest($path){
    let $type:=web:content-type($path)
    let $_:=fn:trace($type,"type: ")
    let $map:=map{
                  "application/xquery": doc:xqdoc_#1
                }
   return if(map:contains($map,$type))  then $map($type)($path) else $path
};

let $db:="doc-doc" 
let $src:=fn:resolve-uri("../data/doc")
return (dbtools:sync-from-files(
                            $db
                           ,$src
                           ,file:list($src,fn:true())
                           ,task:ingest#1 )
        ,db:output("dbsync")
        )
