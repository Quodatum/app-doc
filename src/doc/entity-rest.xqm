(:~ 
:abide app rest interface 
: @author andy bunce
: @since jun 2013
:)

module namespace model-rest = 'quodatum.model.rest';
declare default function namespace 'quodatum.model.rest'; 

import module namespace entity ='quodatum.models.generated' at "models.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "lib/dice.xqm"; 
import module namespace web = 'quodatum.web.utils2' at "lib/webutils2.xqm";

declare variable $model-rest:models:=db:open("doc-models")//entity;
(:~ 
 : return list of entities 
 :)
declare 
%rest:GET %rest:path("doc/data/entity")
%rest:query-param("q", "{$q}") 
%output:method("json")    
function model-list($q) {
 let $entity:=$entity:list("entity")
 let $items:=$model-rest:models
 let $items:=if($q)then $items[fn:contains($entity("access")("name")(.),$q)] else $items
 return dice:response($items,$entity,())
};

(:~ 
 : model list
 :)
declare 
%rest:GET %rest:path("doc/data/entity/{$app}")
%output:method("json")    
function app($app) {
let $fields:=entity:fields("entity")
 let $item:=$model-rest:models[@name=$app]
 (: just one :)
 return <json objects="json">{dice:json-flds($item,$fields)/*}</json>

};

(:~ 
 : field list for model 
 :)
declare 
%rest:GET %rest:path("doc/data/entity/{$app}/fields")
%output:method("json")    
function field-list($app) {
 let $entity:=$entity:list("field")
    let $items:=$model-rest:models[@name=$app]/fields/field
	let $crumbs:=(<_><name>{$app}</name><slug>{$app}</slug></_>,
                  <_><name>fields</name><slug>fields</slug></_>)
    return dice:response($items,$entity,$crumbs)
                      
};