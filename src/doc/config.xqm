(:~ 
 : config stuff
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace cnf = 'quodatum.app.config';
declare default function namespace 'quodatum.app.config';

declare variable $cnf:name:="doc";

declare %updating function write-log($text as xs:string){
    admin:write-log("[" || $cnf:name || "] " || $text)
}; 