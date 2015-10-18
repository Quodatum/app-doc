import module namespace entity = 'quodatum.models.generated' at '../generated/models.xqm';
import module namespace dice = 'quodatum.web.dice/v3' at "../lib/dice.xqm";
declare namespace xqdoc ="http://www.xqdoc.org/1.0";

let $entity:=$entity:list( "xqmodule")
let $items:=$entity?data()
return 
(: $items/xqdoc:module/@type/string()=>distinct-values() :)
dice:response(
  $items,$entity,map{
    "limit":4
  }
) 