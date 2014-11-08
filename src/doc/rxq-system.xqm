(:~ 
 : A RESTXQ interface for common system functionality
 : includes tasks
 :
 :@copyright Quodatum Ltd
 :@license Apache 2
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace dr = 'quodatum.system.rest';
declare default function namespace 'quodatum.system.rest'; 

import module namespace tasks = 'quodatum.tasks.generated' at 'generated/tasks.xqm';
import module namespace df = 'quodatum.doc.file' at "lib/files.xqm";
import module namespace eval = 'quodatum.eval' at "lib/eval.xqm";


(:~
 :  run a task
 :)
declare %updating
%output:method("text")  
%rest:POST %rest:path("{$app}/task/{$task}")
function dotask($app,$task){
    (tasks:task($task),db:output("run " || $task))
};
