(:~ 
: entity rest interface 
: defines urls below doc/data/entity/
: @author andy bunce
: @since jun 2013
:)

module namespace model-rest = 'quodatum.model.rest';
declare default function namespace 'quodatum.model.rest'; 

import module namespace entity ='quodatum.models.generated' at "generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v2' at "lib/dice.xqm"; 
import module namespace web = 'quodatum.web.utils4' at "lib/webutils.xqm";
declare namespace ent="https://github.com/Quodatum/app-doc/entity"; 

declare variable $model-rest:models:=db:open("doc-doc")//ent:entity;

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
 : details of the entity $entity
 :)
declare 
%rest:GET %rest:path("doc/data/entity/{$entity}")
%output:method("json")    
function model($entity) {
 let $fields:=entity:fields("entity")
 let $item:=$model-rest:models[@name=$entity]
 (: just one :)
 return <json objects="json">{dice:json-flds($item,$fields)/*}</json>

};

(:~ 
 : field list for model 
 :)
declare 
%rest:GET %rest:path("doc/data/entity/{$entity}/field")
%output:method("json")    
function field-list($entity) {
 let $fentity:=$entity:list("field")
    let $items:=$model-rest:models[@name=$entity]/fields/field
	let $crumbs:=(<_><name>{$entity}</name><slug>{$entity}</slug></_>,
                  <_><name>fields</name><slug>fields</slug></_>)
    return dice:response($items,$fentity,$crumbs)
                      
};