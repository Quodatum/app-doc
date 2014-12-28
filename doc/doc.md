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