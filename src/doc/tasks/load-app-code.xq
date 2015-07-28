(:~
 : update database "doc-{$app}" with generated xquery documentation (xqdoc)
 : for all *,xq and *.xqm files in app 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

import module namespace doc = 'quodatum.doc' at "../doctools.xqm";
import module namespace df = 'quodatum.doc.file' at "../lib/files.xqm";

let $app:="doc"
let $db:="doc-" || $app
let $src:=fn:resolve-uri("..")
let $_:=fn:trace($src ,"src:__")

let $files:=df:dir($src,"*.xqm,*.xq")
return (db:output(count($files) || " files added xqdoc to db"),
        for $file in $files   
        let $doc:=doc:xqdoc("app",$src ||$file)
        return db:replace($db,"/modules/" || $file,$doc)
        )