(:~ 
 : A RESTXQ interface for cva bars
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace cva = 'quodatum.cva.rest';
declare default function namespace 'quodatum.cva.rest'; 

(:~
 : @return bar named $bar from app named $app
 :)
declare function getbar($app as xs:string,$bar as xs:string) 
as element(json){
    let $uri:=fn:resolve-uri(fn:concat("../data/bars/",$bar,".xml"))
    return fn:doc($uri)/*!fixup(.)
};
 
(:~
 : convert xml to json driven by @type="array" and convention
 :)
declare function fixup($n){fixup($n,"object")}; 
declare function fixup($n,$type as xs:string)
{
let $a:=<json type="{$type}">{$n/*}</json>
return copy $c := $a
modify (
        (: if  type not set and has children then set type=object :)
            for $type in $c//*[fn:not(@type)and *]
            return insert node attribute {'type'}{'object'} into $type,
         (: rename children for arrays :)   
            for $n in $c//*[@type="array"]/*
            return rename node $n as "_"
        )
return $c
};
