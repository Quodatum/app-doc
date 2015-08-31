(: entity access maps 
 : auto generated from xml files in entities folder at: 2015-08-31T20:44:26.093+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
declare namespace wadl='http://wadl.dev.java.net/2009/02';
declare namespace ent='https://github.com/Quodatum/app-doc/entity';
declare namespace task='https://github.com/Quodatum/app-doc/task';
declare namespace xqdoc='http://www.xqdoc.org/1.0';
          
declare variable $entity:list:=map { 
  "app": map{
     "name": "app",
     "description": "A RESTXQ based web application.",
     "access": map{ 
       "description": function($_ as element()) as xs:string? {$_/description},
       "logo": function($_ as element()) as xs:string? {$_/logo},
       "name": function($_ as element()) as xs:string {$_/name},
       "uri": function($_ as element()) as xs:string? {'/' || $_/name} },
     "json": map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/description)
                        return if($d)
                              then element description { attribute type {"string" },$d } 
                              else () },
           "logo": function($_ as element()) as element(logo)? {
            (: string :)
                        let $d:=fn:data($_/logo)
                        return if($d)
                              then element logo { attribute type {"string" },$d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/name)
                        return if($d)
                              then element name { attribute type {"string" },$d } 
                              else () },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        let $d:=fn:data('/' || $_/name)
                        return if($d)
                              then element uri { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(item)*
       { () }
   },
  "component-js": map{
     "name": "component-js",
     "description": "About a javascript library",
     "access": map{ 
       "cdn": function($_ as element()) as xs:string {$_/release/cdn[1]},
       "name": function($_ as element()) as xs:string {$_/@name},
       "tagline": function($_ as element()) as xs:string {$_/tagline} },
     "json": map{ 
           "cdn": function($_ as element()) as element(cdn)? {
            (: string :)
                        let $d:=fn:data($_/release/cdn[1])
                        return if($d)
                              then element cdn { attribute type {"string" },$d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element name { attribute type {"string" },$d } 
                              else () },
           "tagline": function($_ as element()) as element(tagline)? {
            (: string :)
                        let $d:=fn:data($_/tagline)
                        return if($d)
                              then element tagline { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(cmp)*
       { () }
   },
  "endpoint": map{
     "name": "endpoint",
     "description": "A WADL type wadl:resource",
     "access": map{ 
       "doc": function($_ as element()) as xs:string {if($_/wadl:method/wadl:doc) 
			       then $_/wadl:method/wadl:doc/text()
			       else ''},
       "mediatype": function($_ as element()) as xs:string {$_/wadl:method/wadl:response/wadl:representation/@mediaType},
       "method": function($_ as element()) as xs:string {$_/wadl:method/@name},
       "path": function($_ as element()) as xs:string {$_/@path} },
     "json": map{ 
           "doc": function($_ as element()) as element(doc)? {
            (: string :)
                        let $d:=fn:data(if($_/wadl:method/wadl:doc) 
			       then $_/wadl:method/wadl:doc/text()
			       else '')
                        return if($d)
                              then element doc { attribute type {"string" },$d } 
                              else () },
           "mediatype": function($_ as element()) as element(mediatype)? {
            (: string :)
                        let $d:=fn:data($_/wadl:method/wadl:response/wadl:representation/@mediaType)
                        return if($d)
                              then element mediatype { attribute type {"string" },$d } 
                              else () },
           "method": function($_ as element()) as element(method)? {
            (: string :)
                        let $d:=fn:data($_/wadl:method/@name)
                        return if($d)
                              then element method { attribute type {"string" },$d } 
                              else () },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        let $d:=fn:data($_/@path)
                        return if($d)
                              then element path { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(wadl:resource)*
       { () }
   },
  "entity": map{
     "name": "entity",
     "description": "About an entity i.e. something described in this framework",
     "access": map{ 
       "code": function($_ as element()) as xs:string? {$_/ent:data},
       "description": function($_ as element()) as xs:string {$_/ent:description},
       "fieldslink": function($_ as element()) as xs:string {fn:concat("/data/entity/",$_/@name,"/field")},
       "iconclass": function($_ as element()) as xs:string {$_/ent:iconclass},
       "name": function($_ as element()) as xs:string {$_/@name},
       "nfields": function($_ as element()) as xs:integer {fn:count($_/ent:fields/ent:field)},
       "parent": function($_ as element()) as xs:string? {$_/ent:parent/@name},
       "parentlink": function($_ as element()) as xs:string? {fn:concat("/data/entity/",$_/ent:parent/@name)},
       "type": function($_ as element()) as xs:string {$_/ent:data/@type} },
     "json": map{ 
           "code": function($_ as element()) as element(code)? {
            (: string :)
                        let $d:=fn:data($_/ent:data)
                        return if($d)
                              then element code { attribute type {"string" },$d } 
                              else () },
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/ent:description)
                        return if($d)
                              then element description { attribute type {"string" },$d } 
                              else () },
           "fieldslink": function($_ as element()) as element(fieldslink)? {
            (: string :)
                        let $d:=fn:data(fn:concat("/data/entity/",$_/@name,"/field"))
                        return if($d)
                              then element fieldslink { attribute type {"string" },$d } 
                              else () },
           "iconclass": function($_ as element()) as element(iconclass)? {
            (: string :)
                        let $d:=fn:data($_/ent:iconclass)
                        return if($d)
                              then element iconclass { attribute type {"string" },$d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element name { attribute type {"string" },$d } 
                              else () },
           "nfields": function($_ as element()) as element(nfields)? {
            (: number :)
                        let $d:=fn:data(fn:count($_/ent:fields/ent:field))
                        return if($d)
                              then element nfields { attribute type {"number" },$d } 
                              else () },
           "parent": function($_ as element()) as element(parent)? {
            (: string :)
                        let $d:=fn:data($_/ent:parent/@name)
                        return if($d)
                              then element parent { attribute type {"string" },$d } 
                              else () },
           "parentlink": function($_ as element()) as element(parentlink)? {
            (: string :)
                        let $d:=fn:data(fn:concat("/data/entity/",$_/ent:parent/@name))
                        return if($d)
                              then element parentlink { attribute type {"string" },$d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/ent:data/@type)
                        return if($d)
                              then element type { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(ent:entity)*
       { db:open("doc-doc")//ent:entity }
   },
  "field": map{
     "name": "field",
     "description": "About an entity field.",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/ent:description},
       "name": function($_ as element()) as xs:string {$_/@name},
       "type": function($_ as element()) as xs:string {$_/@type},
       "xpath": function($_ as element()) as xs:string {$_/ent:xpath} },
     "json": map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/ent:description)
                        return if($d)
                              then element description { attribute type {"string" },$d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element name { attribute type {"string" },$d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/@type)
                        return if($d)
                              then element type { attribute type {"string" },$d } 
                              else () },
           "xpath": function($_ as element()) as element(xpath)? {
            (: string :)
                        let $d:=fn:data($_/ent:xpath)
                        return if($d)
                              then element xpath { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(ent:field)*
       { () }
   },
  "search-result": map{
     "name": "search-result",
     "description": "About a search result.",
     "access": map{ 
       "sref": function($_ as element()) as xs:string {"app.item.index({'name':'benchx'})"},
       "title": function($_ as element()) as xs:string {$_/title},
       "type": function($_ as element()) as xs:string {$_/type},
       "uri": function($_ as element()) as xs:string {$_/uri} },
     "json": map{ 
           "sref": function($_ as element()) as element(sref)? {
            (: string :)
                        let $d:=fn:data("app.item.index({'name':'benchx'})")
                        return if($d)
                              then element sref { attribute type {"string" },$d } 
                              else () },
           "title": function($_ as element()) as element(title)? {
            (: string :)
                        let $d:=fn:data($_/title)
                        return if($d)
                              then element title { attribute type {"string" },$d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/type)
                        return if($d)
                              then element type { attribute type {"string" },$d } 
                              else () },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        let $d:=fn:data($_/uri)
                        return if($d)
                              then element uri { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(search)*
       { () }
   },
  "task": map{
     "name": "task",
     "description": "A piece of runnable XQuery code that causes side effects",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:comment/xqdoc:description},
       "name": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:uri},
       "path": function($_ as element()) as xs:string {concat(db:name($_),"/",db:path($_))},
       "xquery": function($_ as element()) as xs:string {'todo'} },
     "json": map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)
                        return if($d)
                              then element description { attribute type {"string" },$d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:uri)
                        return if($d)
                              then element name { attribute type {"string" },$d } 
                              else () },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        let $d:=fn:data(concat(db:name($_),"/",db:path($_)))
                        return if($d)
                              then element path { attribute type {"string" },$d } 
                              else () },
           "xquery": function($_ as element()) as element(xquery)? {
            (: string :)
                        let $d:=fn:data('todo')
                        return if($d)
                              then element xquery { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(xqdoc:xqdoc)*
       { db:open("doc-doc")//xqdoc:xqdoc[
  xqdoc:namespaces/xqdoc:namespace/@uri="https://github.com/Quodatum/app-doc/task"
 and xqdoc:module/@type="main"
] }
   },
  "xqmodule": map{
     "name": "xqmodule",
     "description": "An XQuery source code module",
     "access": map{ 
       "description": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:comment/xqdoc:description},
       "file": function($_ as element()) as xs:string {fn:substring-after(fn:base-uri($_),"abide-modules/")},
       "href": function($_ as element()) as xs:string {"#/data/xqmodule/item?item=" || fn:base-uri($_)},
       "name": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:name},
       "type": function($_ as element()) as xs:string {$_/xqdoc:module/@type},
       "uri": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:uri} },
     "json": map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)
                        return if($d)
                              then element description { attribute type {"string" },$d } 
                              else () },
           "file": function($_ as element()) as element(file)? {
            (: string :)
                        let $d:=fn:data(fn:substring-after(fn:base-uri($_),"abide-modules/"))
                        return if($d)
                              then element file { attribute type {"string" },$d } 
                              else () },
           "href": function($_ as element()) as element(href)? {
            (: string :)
                        let $d:=fn:data("#/data/xqmodule/item?item=" || fn:base-uri($_))
                        return if($d)
                              then element href { attribute type {"string" },$d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:name)
                        return if($d)
                              then element name { attribute type {"string" },$d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/@type)
                        return if($d)
                              then element type { attribute type {"string" },$d } 
                              else () },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:uri)
                        return if($d)
                              then element uri { attribute type {"string" },$d } 
                              else () } },
      "data": function() as element(xqdoc:xqdoc)*
       { db:open("doc-doc")//xqdoc:xqdoc }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  