(:~
 : update database "doc-{$app}" with generated xquery documentation (xqdoc)
 : for all *,xq and *.xqm files in app 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

import module namespace doc = 'quodatum.doc' at "../doctools.xqm";


let $app:="doc"
let $db:="doc-" || $app
let $src:=fn:resolve-uri("..")
let $_:=fn:trace($src ,"src:__")

let $files:=file:list($src,fn:true(),"*.xqm,*.xq")
for $file in $files

let $doc:=doc:xqdoc("app",$src ||$file)
return (  
      db:replace($db,"/modules/" || $file,$doc),
      db:output($file || " added xqdoc to db")
       )