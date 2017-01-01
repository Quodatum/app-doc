(:~  
 :before unit tests with updates
 : 
 :)
module namespace test = 'http:/quodatum.com//modules/xqunit-tests';

(: not called :)
declare %updating  %unit:before("test:before-this") 
function test:before-before-this() {
 test:log("before-before-this")
};

declare %updating  %unit:before("test:this") 
function test:before-this() {
 test:log("before-this")
};

(:~ will set status. :)
declare %updating %unit:test 
function test:this() {
  test:log("this")
};

declare %updating  %unit:before-module 
function test:before-module() 
{
if(db:exists("!log")) then 
    () 
else 
    db:create("!log", <logs/>, "log.xml") 
};

declare %updating function test:log($text)
{
let $target:=doc("/!log/log.xml")/logs
return insert node <log when="{fn:current-dateTime()}">{$text}</log> into $target 
};
