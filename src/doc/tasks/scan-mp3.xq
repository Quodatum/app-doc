(:~
 : mp3 dir scan 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
import module namespace df = "quodatum.doc.file" at "../lib/files.xqm";
import module namespace tags = 'expkg-zone58:audio.metadata';

declare variable $db:="test-mp3";
declare variable $path external:="C:\Users\andy\Music\David Myles\In The Nighttime- From Dinner Party to Dance Party Disc 1\01 What Would I Have to Do.mp3";

declare function local:tags($f as xs:string) as element(path){
 try {
   element path {attribute path {trace($f)}, tags:read($f)}
 } catch * {
   element path {attribute path {$f},attribute error {true()},$err:description}
 }
};
let $d:= $path=>local:tags()
return db:replace($db,"go.xml",$d)
