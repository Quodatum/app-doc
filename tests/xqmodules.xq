import  module namespace entity = 'quodatum.models.generated' at "../src/doc/generated/models.xqm";
import module namespace dice = 'quodatum.web.dice/v3' at "../src/doc/lib/dice.xqm";
   let $item:="basex.xqm/admin.xqm"
    let $entity:=$entity:list("xqmodule")
    let $results:=$entity("data")()
    let $results:=$results[$item=$entity?access?dbpath(.)]
    return dice:one(fn:head($results),$entity)