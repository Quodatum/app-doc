(:~ 
 : generate xquery access code for entity definitions
 :)
module namespace bf = 'quodatum.tools.buildfields';
declare default function namespace 'quodatum.tools.buildfields'; 
declare namespace ent="https://github.com/Quodatum/app-doc/entity"; 

(:~
 : write generated xquery module from entity xml
 : @param efolder full path to folder with entities e.g. fn:resolve-uri("./data/models")
 : @param dest full name of xqm to create e.g. fn:resolve-uri("models.xqm")
 :)
declare function write($efolder as xs:string,$dest as xs:string)
{
    let $src:=bf:module(bf:sources($efolder))
    return file:write-text($dest,$src)
};

(:~
 : generate xquery module for given entities as a string
 :)
declare function module($entities as element(ent:entity)*) as xs:string
{
let $src:= <text>(: entity access maps 
 : auto generated from xml files in entities folder at: {fn:current-dateTime()} 
 :)

module namespace entity = 'quodatum.models.generated';
{bf:build-namespaces($entities)}
{(  bf:build-describe($entities))} 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){{
  $entity:list($entity)("access")
}}; 
  </text> 

 return $src
};

(:~
 : generate xquery for to return field value in the format: "name"=function(){}
 :)
declare function accessfn($f as element(ent:field)) as xs:string
{
<field>
       "{$f/@name/fn:string()}": function($_ as element()) as {$f/@type/fn:string()} {{{$f/ent:xpath }}}</field>
};

declare function generate($e as element(ent:entity)) as xs:string
{
  let $fields:=for $field in $e/ent:fields/ent:field   
                order by $field/@name
                return $field    
  return <field>
  "{$e/@name/fn:string()}":= map{{
     "name": "{ $e/@name/fn:string()}",
     "description": "{ escape($e/ent:description)}",
     "access": map{{ {fn:string-join($fields!accessfn(.),",")} }},
     "json":= map{{ {fn:string-join($fields!jsonfn(.),",")} }}
   }}</field>
};

(:~
 : @return sequence of element(entity) items for definitions at path
 :)
declare function sources($path as xs:string) as element(ent:entity)*
{
 let $p:=fn:resolve-uri($path) || "/"
 return for $f in file:list($p)
        order by $f
        return fn:doc(fn:concat($p,$f))/ent:entity
};

(:map for entity :)
declare function build-map($entity as element(ent:entity)) as xs:string
{
let $m:=for $field in $entity/ent:fields/ent:field   
        order by $field/@name
        return accessfn($field)
return <text>
declare variable $entity:{$entity/@name/fn:string()}:=map{{ {fn:string-join($m,",")}
}};

</text>        
};

(:~ 
 : javascript funtion to return xml for json serialization
:)
declare function jsonfn($f as element(ent:field)) as xs:string{
let $name:=$f/@name/fn:string()
let $type:=json-type($f/@type)
return <field>
       "{$name}":=function($_ as element()) as element({$name}) {{ element {$name} {{ attribute type {{"{$type}" }},fn:data({$f/xpath }) }} }}</field>
};

(:~ convert xs type to json
:)
declare function json-type($xsd as xs:string) as xs:string{
switch ($xsd) 
   case "xs:boolean" return "boolean"
   case "xs:integer" return "number"
   case "xs:float" return "number"
   case "xs:double" return "number"
   default return "string" 
};

(:~ declare any namespaces found :)
declare function build-namespaces($entities as element()*){
  for $n in distinct-deep($entities/ent:namespace)
  return 
<text>declare namespace {$n/@prefix/fn:string()}='{$n}';
</text>
};

declare function build-describe($entities){
  let $m:=for $e in  $entities
          return generate($e)
  return <text>          
declare variable $entity:list:=map {{ {fn:string-join($m,",")}
}};

</text>        
};

declare function escape($str as xs:string) 
as xs:string{
   fn:replace(
     fn:replace($str,'"','""'),
     "'","''")
};

(:-----from functx-------------------:)

 declare function distinct-deep 
  ( $nodes as node()* )  as node()* {
       
    for $seq in (1 to fn:count($nodes))
    return $nodes[$seq][fn:not(is-node-in-sequence-deep-equal(
                          .,$nodes[fn:position() < $seq]))]
};

declare function is-node-in-sequence-deep-equal 
  ( $node as node()? ,
    $seq as node()* )  as xs:boolean {
       
   some $nodeInSeq in $seq satisfies fn:deep-equal($nodeInSeq,$node)
 } ; 