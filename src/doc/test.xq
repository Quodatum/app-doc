import module namespace entity = 'quodatum.models.generated' at 'generated/models.xqm';
import module namespace dice = 'quodatum.web.dice/v3' at 'lib/dice.xqm';
let $entity:=$entity:list("xqmodule")
    let $results:=$entity("data")()
   return  dice:response($results, $entity,map{"start":40})