(:~
 : update database with xqdoc and xparse doc for all xqm
 : for all *,xq and *.xqm files in all apps 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare namespace xqdoc="http://www.xqdoc.org/1.0";
import module namespace xp="expkg-zone58:text.parse";
import module namespace doc = 'quodatum.doc' at "../doctools.xqm";
import module namespace df = 'quodatum.doc.file' at "../lib/files.xqm";

let $db:="doc-doc"
let $src:=df:webpath(".")

let $files:=df:dir($src,"*.xqm,*.xq")
return 
(db:output("modules processed: " || count($files) )
         ,for $file in $files
         let $ufile:= translate($file,"\","/")
         let $text:="" || file:read-text($src || trace($file)) 
           
       let $parse:= xp:parse($text,map{"lang":"xquery"})
        let $ppath:="/parse/" ||  $ufile || ".xparse"
        
         let $doc:=doc:xqdoc("app",$src ||$file)
        let $docpath:="/apps/" ||  $ufile
        
        return (
                db:replace($db,$docpath,$doc) 
               ,db:replace($db,$ppath,$parse)
        ) 
      )