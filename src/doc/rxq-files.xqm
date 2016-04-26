(:~ 
 : A RESTXQ interface for documentation files
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace dr = 'quodatum.doc.files';
declare default function namespace 'quodatum.doc.files';


import module namespace df = 'quodatum.doc.file' at "lib/files.xqm";
import module namespace rest = "http://exquery.org/ns/restxq";



(:~
 : list of direct children of $path as json array
 : @param $path path to list the children of eg "/app"  
 : @return json [ {name:"gg","path:"aaa/bb",isdir:false},{}..]
 :)
declare
%rest:GET %rest:path("doc/data/file/list")
%rest:query-param("path", "{$path}","/")
%rest:query-param("search", "{$search}","")    
%output:method("json")   
function files($path,$search) as element(json) 
{
    if(fn:normalize-space($search))
    then   <json type="array">{df:find("/",$search)}</json> 
    else <json type="array">{df:list($path)}</json>
};

(:~
 : list of files matching pattern as json array
 : @param $path eg "/app"  
 : @return json [ {name:"gg","path:"aaa/bb",isdir:false},{}..]
 :)
declare
%rest:GET %rest:path("doc/data/file/find")
%rest:query-param("pattern", "{$pattern}","") 
%output:method("json")   
function find($pattern) as element(json) 
{
    <json type="array">{df:find("/",$pattern)}</json>
};

(:~
 : get contents of file.
 : @param $path e.g. "/app/doc/readme.md"
 : @return text resprestation of file
 :)
declare
%rest:GET %rest:path("doc/data/file/read")
%rest:query-param("path", "{$path}","/")  
%output:method("text")   
function read($path) as xs:string? 
{ 
    df:read($path)
};

