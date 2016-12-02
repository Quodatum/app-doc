declare base-uri "file:///C:/Program%20Files%20(x86)/BaseX/webapp/doc/tasks/file";
(:~ 
 :  mp3 dir scan
 : 271 secs 2015-11-01 
 :)

import module namespace promise = 'org.jw.basex.async.xq-promise';
declare namespace task="https://github.com/Quodatum/app-doc/task";
declare  %updating function local:foo($xqdoc)
{
   db:replace("doc-doc","modules/tasks/filelist-promise.xq",$xqdoc)
};

let $xqdoc:=inspect:xqdoc("C:\Program Files (x86)\BaseX\webapp\doc\tasks\filelist-promise.xq")
return local:foo($xqdoc)