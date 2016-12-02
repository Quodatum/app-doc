(:~
 : a slow task 
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
let $r:=(1 to 500000000)[0=.] (: 20 seconds :)
return db:output("nothing yet: " || count($r))