import module namespace tree = "quodatum.data.tree" at "tree.xqm";


declare variable $base:="C:\Program Files (x86)\basex\webapp\doc\";
declare function local:test($f){
  let $f:=translate($f,"\","/")
  return if(starts-with($f,"/"))then $f else "/" || $f
};

declare function local:canonical($f as xs:string,$pre as xs:string){
 let $f:=translate($f,"\","/")
 return  $pre || $f
};

(: for $f in file:list($base,fn:true(),"*.xqm,*.xq")
return (file:resolve-path(".ignore",file:resolve-path($f,$base))) :)
 file:list($base,fn:true(),"*.xqm,*.xq")
!local:canonical(.,"/doc/")
=>tree:trees()