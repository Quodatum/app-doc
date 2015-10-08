# render

````
let $render:=map{"xml":function($doc){$doc},
            "svg":function($doc){<svg/>}
            }
let $doc:=<foo/>
let $fmt:="www"
return $render?($fmt,"svg")[1]($doc)
````