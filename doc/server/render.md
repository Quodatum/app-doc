# render

````
let $render:=map{"xml":function($doc){$doc},
            "svg":function($doc){<svg/>}
            }
let $doc:=<foo/>
let $fmt:="www"
return $render?($fmt,"svg")[1]($doc)
````
## Default values
````
(:~ config values for render :)
declare  function settings(){
   map{
    "version":$cnf:package/@version/fn:string(),
    "static":"/static/doc/",
    "incl-css":$cnf:includes/css/*,
    "incl-js":$cnf:includes/js/*
   }
};
```` 