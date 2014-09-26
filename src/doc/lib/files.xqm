(:~ 
 : file system tools
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace df = 'quodatum.doc.file';
declare default function namespace 'quodatum.doc.file'; 

(:~
 : path to webapps with trailing slash 
 :)
declare variable $df:base:= db:system()/globaloptions/webpath/fn:string()
                             || file:dir-separator();

(:~ true path from segment :)
declare function path($path as xs:string)
 as xs:string{
 $df:base || $path
};

(:~
 : list of files 
 : @return json array {name:"gg","path:"aaa/bb",isdir:false}
 :)
declare   
function list($dir) as element(json) 
{
    let $fdir:= path($dir)
    let $xq:=file:list($fdir)
    let $xq:=$xq
    let $f:=function($d,$isFolder){
             let $d:=fn:translate($d,"\","/")
             return   
              <_ type="object">
                 <name>{$d}</name>
                 <path>{$dir || $d}</path>
                 <isdir type="boolean">{$isFolder}</isdir>
              </_>}
    return 
    <json type="array">
      {for $ls in $xq   
       let $isFolder:=file:is-dir($fdir ||$ls)
       order by $isFolder descending,fn:lower-case($ls)
       return $f($ls,$isFolder)
      }      
 </json>
};

declare function read($dir) as item() 
{
    let $fdir:= path($dir)
    return if(fn:doc-available($fdir))
           then fn:serialize(fn:doc($fdir))
           else if(fn:unparsed-text-available($fdir))
           then fn:unparsed-text($fdir)
           else ()
};


declare function is-text-file($path) as xs:boolean{
    is-text(file:read-binary($path,0,1024))
};

(:~ 
 : test for text
 : @see http://stackoverflow.com/questions/2644938/how-to-tell-binary-from-text-files-in-linux
 :) 
declare function is-text($b as xs:base64Binary )
as xs:boolean{
  fn:empty(bin:find($b, 0,convert:bytes-to-base64(xs:byte(0))))
};