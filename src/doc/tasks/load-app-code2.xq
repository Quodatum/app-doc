(:~
 : update database with xparse doc for all xqm
 : for all *,xq and *.xqm files in all apps 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare namespace xqdoc="http://www.xqdoc.org/1.0";
import module namespace xp="http://expath.org/ns/xparse";
import module namespace doc = 'quodatum.doc' at "../doctools.xqm";
import module namespace df = 'quodatum.doc.file' at "../lib/files.xqm";
declare variable $app external :="doc";

let $db:="doc-doc" 
let $src:=df:webpath("/")

let $files:=df:dir($src,"*.xqm,*.xq")
return 
(db:output("modules processed: " || count($files) )
         ,for $file in $files
         let $text:="" || file:read-text($src || trace($file))   
        let $doc:= xp:parse($text,map{"lang":"xquery"})
        let $path:="/apps/" ||  $file || ".parse"=>translate("\","/")
        return db:replace($db,$path,$doc) 
        ) 