(:~
 : update database "doc-doc" with generated xquery documentation for
 : the basex system modules (xqdoc)
 :  
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace doc = 'quodatum.doc' at "../doctools.xqm";


let $app:="doc"
let $db:="doc-" || $app
let $files:=doc:basex-modules()
return ( 
  db:output(count($files) || " files added xqdoc to db"),
  for  $name in $files
  let $xqdoc:=doc:xqdoc("app",$name)
  return db:replace($db,"/basex/" || $name,$xqdoc)
  )