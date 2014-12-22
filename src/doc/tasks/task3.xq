(:~
 : update database with generated xquery documentation (xqdoc) 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare namespace xqdoc="http://www.xqdoc.org/1.0";
import module namespace dbtools = 'quodatum.dbtools'  at "../lib/dbtools.xqm";

declare function local:xqdoc($path as xs:string){
    try{
        inspect:xqdoc($path)
    } catch * {
     <xqdoc:xqdoc type="err">{$path}</xqdoc:xqdoc>
    }
};
let $db:="doc-doc" 
let $src:=fn:resolve-uri("..")

let $files:=file:list($src,fn:true(),"*.xqm,*.xq")
return (
        for $file in $files
        let $_:=fn:trace($src ||$file,"____")
        let $doc:=local:xqdoc($src ||$file)
        return  
        db:replace($db,"/modules/" || $file,$doc),
         db:output("xqdoc to db")
         )