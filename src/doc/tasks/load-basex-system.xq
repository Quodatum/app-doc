(:~
 : update database "doc-doc" with generated xquery documentation for
 : the basex system modules (xqdoc)
 :  
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace doc = 'quodatum.doc' at "../doctools.xqm";


let $app:="doc"
let $db:="doc-" || $app

for $name in doc:basex-modules()
let $xqdoc:=doc:xqdoc("basex",$name)
return (
        db:replace($db,"/basex/" || $name,$xqdoc),
        db:output($name || " added xqdoc to db")
        )
