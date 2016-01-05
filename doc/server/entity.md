## sample data access
````xquery
import module namespace entity = 'quodatum.models.generated' at "doc/generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "doc/lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";

let $e:=$entity:list("task") (: get task definition :)
let $data:= $e("data")()[1] (: get first :)
return $data
```` 