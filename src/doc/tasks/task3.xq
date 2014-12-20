(:~
 : update database with generated xquery documentation (xqdoc) 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace dbtools = 'quodatum.dbtools'  at "../lib/dbtools.xqm";

let $db:="doc-data" 
let $src:=fn:resolve-uri("..")
let $files:=file:list($src,fn:true(),"*.xqm,*.xq")
for $file in $files
let $doc:=inspect:xqdoc($src ||$file)
return  db:replace($db,"/modules/" || $file,$doc)