(: entity access maps 
 : hand generated 
 :)

module namespace entity = 'apb.models.generated';

          
declare variable $entity:list:=map { 
  "application":= map{
     "name":= "application",
     "description":= "A RESTXQ based web application described by the AIDE framework.",
     "access":= map{ 
       "name":=function($_ as element()) as xs:string {$_/name} },
     "json":= map{ 
        "name":=function($_ as element()) as element(name) { element name { attribute type {"string" },fn:data($_/name) } } }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  