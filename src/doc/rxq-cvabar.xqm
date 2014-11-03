(:~ 
 : A RESTXQ interface for cva bars
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace cva = 'quodatum.cva.rest';
declare default function namespace 'quodatum.cva.rest'; 

(:~
 : show xqdoc for rest api
 :)
declare 
%rest:GET %rest:path("{$app}/meta/cvabar/{$bar}")
%output:method("json")  
function xqdoc($app as xs:string,$bar as xs:string) 
{
    (: @TODO fix this :)
    let $uri:=fn:resolve-uri(fn:concat("../",$app,"/data/",$app,"/bars/",$bar,".xml"))
    return fn:doc($uri)/*!fixup(.)
};
 
(:~
 : convert xml to json driven by @type="array" and convention
 :)
declare function fixup($n){fixup($n,"object")}; 
declare function fixup($n,$type)
{
let $n:=strip-ns($n)
let $a:=<json type="{$type}">{$n/*}</json>
return copy $c := $a
modify (
            for $type in $c//*[fn:not(@type)and *]
            return insert node attribute {'type'}{'object'} into $type,
            
            for $n in $c//*[@type="array"]/*
            return rename node $n as "_"
        )
return $c
};

declare function strip-ns($n as node()) as node() {
  if($n instance of element()) then (
    element { fn:local-name($n) } {
      $n/@*,
      $n/node()/strip-ns(.)
    }
  ) else if($n instance of document-node()) then (
    document { $n/node() }
  ) else (
    $n
  )
};
