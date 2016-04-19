
Server URL                      Description

data/component                  list components
data/component/item/ace         detail
data/component.version          list versions
data/component.version/ace      list releases
data/component.version/ace/re      list releases

data/app                        list apps
data/app/abide                  one app
data/app/abide/components       list components


## sample data access
````xquery
import module namespace entity = 'quodatum.models.generated' at "doc/generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "doc/lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";

let $e:=$entity:list("task") (: get task definition :)
let $data:= $e("data")()[1] (: get first :)
return $data
```` 