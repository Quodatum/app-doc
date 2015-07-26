(:~ 
 : convert paths as strings to tree node structure
:)
module namespace tree = 'quodatum.data.tree';
declare default function namespace 'quodatum.data.tree'; 

(:~
 : convert path(s) to tree
 :)
declare function trees($a as xs:string*)
{
fn:fold-right($a,
             (),
             function($a,$b){merge(tree($a),$b)}
            )
};
 
declare %private function build($name as xs:string,
                                $items as element(item)*)
as element(item)
{
  <item><name>{$name}</name>{if($items)then <children type="array">{$items}</children> else ()}</item> 
};

(:~
 :  convert path form to tree
 :)
declare function tree($path as xs:string)
as element(item)
{
  fn:fold-right(
    fn:filter(fn:tokenize($path,"/"), fn:boolean#1),
    (),
    build#2 
   )
};

(:~
 : merge 
 :)
declare %private function merge($a1 as element(item)?,$a2 as element(item)?)
{
 if($a1/name=$a2/name) then
      let $n1:=$a1/children/item/name
      let $n2:=$a2/children/item/name
         
      let $t:=(
        for $x in fn:distinct-values($n1[.=$n2]) (:both:)
        return merge($a1/children/item[name=$x],$a2/children/item[name=$x]),
        
        for $x in fn:distinct-values($n1[fn:not(.=$n2)]) (:only $a1 :)
        return $a1/children/item[name=$x],
        
        for $x in fn:distinct-values($n2[fn:not(.=$n1)]) (:only $a2 :)
        return $a2/children/item[name=$x]
      )
      return build($a1/name,for $x in $t order by $x/name return $x)
 else ($a1,$a2)                        
};





declare %unit:test
(:~
 : smoke test
 :)
function test(){
    let $a:=("/",
    "/api/environment/",
    "/api/execute/",
    "/api/library/",
    "/api/library/",
    "/api/library/{$id}/",
    "/api/library/{$id}/",
    "/api/state/",
    "/api/~testbed/",
    "/api/state/",
    "/api/state/",
    "/api/suite/",
    "/api/suite/{$suite}/",
    "/api/execute/zz")
    let $t:=trees($a)
    return unit:assert(fn:true())
};
