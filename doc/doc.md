# about the doc application
UI http://localhost:8984/doc/#/data/{$entity}
get data from
http://localhost:8984/doc/data/{$entity}

UI url
http://localhost:8984/doc/#/data/entity

http://localhost:8984/doc/#/apps
http://localhost:8984/doc/data/app

## sample data access
````xquery
import module namespace entity = 'quodatum.models.generated' at "C:/Program Files (x86)/basex/webapp/doc/generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "C:/Program Files (x86)/basex/webapp/doc/lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";
let $e:=$entity:list("task") (: get task definition :)
let $data:= $e("data")()[1] (: get first :)
return $data
```` 

## ui-route

Content-Range: items 0-24/66
Note that the total items available (e.g. 66 in this case) is not zero-based. Hence, requesting the last
few items in this data set would return a Content-Range header as follows:
Content-Range: items 40-65/66
According to the HTTP specification, it is also valid to replace the total items available (66 in this case)
with an asterisk (“*”) if the number of items is unknown at response time, or if the calculation of that
number is too expensive. In this case the response header would look like this: