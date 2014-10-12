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
declare function webpath($path as xs:string)
 as xs:string{
 $df:base || $path
};

(:~
 : list of all appications
 :)
declare function apps() as xs:string*
{
    let $root:=$df:base
    for $b in  file:list($root)
    let $full:= $root || file:dir-separator() || $b
    let $name:=file:name($full)
    where file:is-dir($full)and fn:not($name = ('static','WEB-INF'))
    return $name
};
(:~ 
 : serialize file object
 :) 
declare function file($dir,$name,$isFolder) as element(_)
{
     let $name:=fn:translate($name,"\","/")
     return   
      <_ type="object">
         <name>{$name}</name>
         <path>{$dir || $name}</path>
         <isdir type="boolean">{$isFolder}</isdir>
      </_>
};

(:~
 : list of files in directory $dir
 : @return json array {name:"gg","path:"aaa/bb",isdir:false}
 :)
declare   
function list($dir as xs:string) as element(_)*  
{
    let $fdir:= webpath($dir)
    let $xq:=file:list($fdir)
    let $xq:=$xq
    for $name in $xq   
       let $isFolder:=file:is-dir($fdir ||$name)
       order by $isFolder descending,fn:lower-case($name)
       return file($dir,$name,$isFolder)
};

(:~
 : list of files below directory $dir matching pattern
 : @return json array {name:"gg","path:"aaa/bb",isdir:false}
 :)
declare   
function find($dir as xs:string,$pattern as xs:string) as element(_)* 
{
   let $fdir:= webpath($dir)
   let $names:=file:list($fdir,fn:true(),$pattern)
   for $name in $names   
       let $isFolder:=file:is-dir($fdir ||$name)
       order by $isFolder descending,fn:lower-case($name)
       return file($dir,$name,$isFolder)
};

(:~
 : get doc at dir as text, if xml convert to string
 :)
declare function read($dir) as item()* 
{
    let $fdir:= webpath($dir)
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
declare function is-text($b as xs:base64Binary )as xs:boolean
{
  fn:empty(bin:find($b, 0,convert:bytes-to-base64(xs:byte(0))))
};