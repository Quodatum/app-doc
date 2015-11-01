(: mp3 dir scan :)
import module namespace df = "quodatum.doc.file" at "../lib/files.xqm";
import module namespace mp3 = 'expkg-zone58.audio.mp3';

declare variable $db:="test-mp3";
declare variable $path:="C:\Users\andy\";

declare function local:tags($f as xs:string) as element(path){
 try {
   element path {attribute path {trace($f)}, mp3:tags($f)}
 } catch * {
   element path {attribute path {$f},attribute error {true()},$err:description}
 }
};
for $f in df:dir($path,"*.mp3")
return file:resolve-path($f,$path)=>local:tags()
