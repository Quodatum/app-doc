(:~ 
 :check all urls in href.json has status 200
 : 
 :)
module namespace test = 'http://basex.org/modules/xqunit-tests';

declare variable $test:urls:=fn:doc("href.xml")/requests/request[not(@skip)];
declare variable $test:target:="http://localhost:8984/doc/";

(:~ status :)
declare  function test:status($uri) as xs:string{
  http:send-request(<http:request method='get' status-only='true'/>,
  $test:target || $uri)/@status
};
   

(:~ check get status=200 from url list :)
declare %unit:test function test:urls() {
for $req in  $test:urls
let $params:=map:merge($req/param!map:entry(@name,string(.)))
let $url:=web:create-url($req/@url, $params)=>trace()
                    
return test:status($url)!unit:assert-equals(., "200",$url)
};    