import module namespace entity = 'quodatum.models.generated' at 'generated/models.xqm';
let $entity:=$entity:list("component")
    let $results:=$entity("data")()
   return $results