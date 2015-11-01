(:~ 
 :  mp3 dir scan
 : 271 secs 2015-11-01 
 :)
import module namespace df = "quodatum.doc.file" at "../lib/files.xqm";
import module namespace mp3 = 'expkg-zone58.audio.mp3';
import module namespace promise = 'org.jw.basex.async.xq-promise';
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare variable $db:="test-mp3";
declare variable $path:="C:\Users\andy\";

declare function local:tags($relpath as xs:string,$base as xs:string ) as element(path){
let $full:=file:resolve-path($relpath,$base)
return 
       try {
         element path {attribute path {$relpath}, mp3:tags($full)}
       } catch * {
         element path {attribute path {$relpath},attribute error {true()},$err:description}
       }
};

declare function local:tags2($f as xs:string) as element(path){<path/>};

let $p:=
  for $f in df:dir($path,"*.mp3")
  return promise:defer(local:tags(?,$path),$f) 
for $s in promise:fork-join($p)
return db:replace($db,$s/@path,$s)