(: mp3 dir scan :)
import module namespace df = "quodatum.doc.file" at "../lib/files.xqm";
import module namespace mp3 = 'expkg-zone58.audio.mp3';

declare variable $db:="test-mp3";
declare variable $path:="C:\Users\andy\";

declare function local:tags($f){
 try {
   element path {attribute path {$f}, mp3:tags($f)}
 } catch * {
   element path {attribute path {$f}, mp3:tags($f)}
 }
};
for $f in df:dir($path,"*.mp3")
let $full:=file:resolve-path($f,$path)
return local:tags($full)
