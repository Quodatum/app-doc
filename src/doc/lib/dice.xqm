(:~ 
: dice utils - sort, filter, and serialize as json..
: @author andy bunce
: @since mar 2013
:)

module namespace dice = 'quodatum.web.dice';
declare default function namespace 'quodatum.web.dice'; 
declare namespace restxq = 'http://exquery.org/ns/restxq';
import module namespace request = "http://exquery.org/ns/request";

(:~ 
 : sort items
 : @param sort  field name to sort on optional leading +/-
 : @return sorted items 
 :)
declare function sort($items as item()*
                     ,$fmap as map(*)
                     ,$sort as xs:string?)
as item()*{
  let $sort:=fn:normalize-space($sort)
  let $ascending:=fn:not(fn:starts-with($sort,"-"))
  let $fld:=fn:substring($sort,if(fn:substring($sort,1,1)=("+","-")) then 2 else 1)
  return if(fn:not(map:contains($fmap, $fld))) then
            $items
          else if ($ascending) then
            for $i in $items
            let $i:=fn:trace($i,"feld " || $fld )
            order by $fmap($fld)($i) ascending
            return $i
          else
            for $i in $items 
            order by  $fmap($fld)($i) descending
            return $i
};

(:~ generate item xml for all fields in map :)
declare function json-flds($item,$fldmap)
{
  json-flds($item,$fldmap,map:keys($fldmap)) 
};

(:~ generate item xml for some fields in map :)
declare function json-flds($item as element(),
                           $fldmap as map(*),
						   $keys as xs:string*)
as element(_){ 
    <_> 
    {for $key in $keys 
	return element {$key}{
    try{
       $fldmap($key)($item)
    }catch * {
       $err:description
    }} }
	</_>
};

(:~
 : @return json styled subsequence from items with metadata 
 : @items 
 : @param fn function to extract o/p fields from i/p node
 : @param $crumbs options breadcrumbs e.g. <_><name>ff</name><slug>aaa</slug><_>
 :)
declare function json-limit($items as item()*,
                            $fn as function(*),
							$start as xs:integer,
							$limit as xs:integer,
							$crumbs as element(_)*)
as element(json){
  <json arrays="items crumbs" objects="json _" numbers="total">
    <total>{fn:count($items)}</total>
	{if($crumbs) then <crumbs>{$crumbs}</crumbs> else() }
    <items>
	    {for $item in fn:subsequence($items,1+$start,$limit)
	    return $fn($item)}
    </items>
  </json>
};

declare function json-limit($items as item()*,
                            $fn as function(*),
							$start as xs:integer,
							$limit as xs:integer)
as element(json){
  json-limit( $items ,$fn,$start,$limit,())
};

(:~ 
 : sort, slice, return json using request parameters
 : @param $items sequence of source items
 :)
declare function json-request($items,$fields,$fn,$crumbs){
  let $start:=xs:integer(fn:number(request:parameter("start","0")))
  let $limit:=xs:integer(fn:number(request:parameter("limit","30")))
  let $sort:=request:parameter("sort","")
  let $items:= dice:sort($items,$fields,$sort)
   return dice:json-limit($items,
                          dice:json-flds(?,$fields),
                          $start,$limit,
                          $crumbs
                          )  
};

(:~ 
 : sort, slice, return json
 :)
declare function json-request($items,$fields,$fn){
    json-request($items,$fields,$fn,())
};

declare function status($code,$reason){
   <restxq:response>            
       <http:response status="{$code}" reason="{$reason}"/>
   </restxq:response>
};

