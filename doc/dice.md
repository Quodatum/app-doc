# dice

## Server
A framework to generate dynamically filtered and sorted json data.
Uses entity model

load modules
```
import module namespace dice = 'quodatum.web.dice/v3' at "C:\Users\andy\workspace\app-doc\src\doc\lib\dice.xqm";
import module namespace entity = 'quodatum.models.generated' at 'C:\Users\andy\workspace\app-doc\src\doc\generated\models.xqm';
```
usage
```
 let $entity:=$entity:list($entity)
 let $results:=$entity("data")()
 let $results:=if($q) then fn:filter($results,$entity?filter(?,$q)) else $results 
```

$entity
?data  returns a function returning a sequence of all the data items
?access  returns as map keys are fields items are functions F(item) returning value of key
?json map(xs:string,function()) returns json
?filter  function($item,$q) 

## Client
DiceService in doc/services.js
Requests data using current parameters.


DiceService.one('app', app).then(function(d) {
            $scope.app = d;
            // console.log(">>", d);
          });