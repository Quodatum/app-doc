(:~ 
 :check all urls in href.json has status 200
 : 
 :)
module namespace test = 'http://basex.org/modules/xqunit-tests';

declare variable $test:urls:=fn:unparsed-text("href.json")!parse-json(.,map{"liberal":fn:true()})?*;
declare variable $test:target:="http://localhost:8984/doc/";

(:~ status :)
declare  function test:status($uri) as xs:string{
  http:send-request(<http:request method='get' status-only='true'/>,$test:target || $uri)/@status
};
   

(:~ check get status=200 from url list :)
declare %unit:test function test:urls() {
for $i in  $test:urls
let $url:=web:create-url($i?url,
                        if(empty($i?params)) then map{} else  $i?params 
                      )
return test:status($url)!unit:assert-equals(., "200",$i?url)
};    