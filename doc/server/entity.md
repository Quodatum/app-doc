#Sample uri

```
    Server URL                      Description
    
    data/component                  list components
    data/component/item/ace         detail
    data/component.version          list versions
    data/component.version/ace      list releases
    data/component.version/ace/re      list releases
    
    data/app                        list apps
    data/app/abide                  one app
    data/app/abide/components       list components
```

## Introduction
xml files in `/models` are used to generate `models.xqm`


    $entity:list
     "component.version": map{
         "name": "component.version",
         "description": "A specific version of a component.",
         "access": map{ 
           "component": function($_ as element()) as xs:string {$_/@name },
           "found": function($_ as element()) as xs:boolean {$_/@found },
           "status": function($_ as element()) as xs:string {$_/@status },
           "version": function($_ as element()) as xs:string {$_/@version } },
        
         "filter": function($item,$q) as xs:boolean{ 
             some $e in ( $item/@name) satisfies
             fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
          },
           "json":   map{ 
               "component": function($_ as element()) as element(component)? {
                (: string :)
                            fn:data($_/@name)!element component {  .} 
                     },
               "found": function($_ as element()) as element(found)? {
                (: boolean :)
                            fn:data($_/@found)!element found { attribute type {'boolean'}, .} 
                     },
               "status": function($_ as element()) as element(status)? {
                (: string :)
                            fn:data($_/@status)!element status {  .} 
                     },
               "version": function($_ as element()) as element(version)? {
                (: string :)
                            fn:data($_/@version)!element version {  .} 
                     } },
          "data": function() as element(pkg:dependency)*
           { for $r in cmpx:comps()/comp:release
    return <pkg:dependency  name="{$r/../@name}" version="{$r/@version}" found="true" status="ok"/> }
         "views":map{"name":"fld list"}
       },
```

## sample data access
```xquery
import module namespace entity = 'quodatum.models.generated' at "C:\Users\andy\workspace\app-doc\src\doc\generated\models.xqm";
$entity:list("database")  ("data")() 
```
more
```xquery
import module namespace entity = 'quodatum.models.generated' at "doc/generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "doc/lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";

let $e:=$entity:list("task") (: get task definition :)
let $data:= $e("data")()[1] (: get first :)
return $data
``` 

### field access
```
declare  base-uri "C:/Users/andy/workspace/app-doc/src/";
import module namespace entity = 'quodatum.models.generated' at "doc/generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v3' at "doc/lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";

let $e:=$entity:list("component") (: get task definition :)
let $data:= $e("data")()[1] (: get first :)
return $e?json?html($data)
```
### with dice
