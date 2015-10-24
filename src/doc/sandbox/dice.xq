(:~ 
 : get fields of the entity app  
:)
import module namespace model = 'quodatum.models.generated' at '../generated/models.xqm';
import module namespace dice = 'quodatum.web.dice/v3' at "../lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";
declare namespace entity="https://github.com/Quodatum/app-doc/entity";

  let $entity:="app" 
    let $items:=$model:list("entity")?data()
    let $items:=$items[@name=$entity]/entity:fields/entity:field
return
dice:response($items,$model:list("field"),map{})
(: $items/xqdoc:module/@type/string()=>distinct-values()
  $items,$entity,map{
    "limit":40
  }
)
 :)
(: $items :)