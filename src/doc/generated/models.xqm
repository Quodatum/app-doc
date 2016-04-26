(: entity access maps 
 : auto generated from xml files in entities folder at: 2016-04-26T10:41:59.518+01:00 
 :)

module namespace entity = 'quodatum.models.generated';
import module namespace cmpx='quodatum.cmpx';
import module namespace xqdoc-html='quodatum.xqdoc.html';
declare namespace pkg='http://expath.org/ns/pkg';
declare namespace comp='urn:quodatum:qd-cmpx:component';
declare namespace wadl='http://wadl.dev.java.net/2009/02';
declare namespace ent='https://github.com/Quodatum/app-doc/entity';
declare namespace task='https://github.com/Quodatum/app-doc/task';
declare namespace xqdoc='http://www.xqdoc.org/1.0';
          
declare variable $entity:list:=map { 
  "app": map{
     "name": "app",
     "description": "A RESTXQ based web application.",
     "access": map{ 
       "description": function($_ as element()) as xs:string? {$_/description },
       "logo": function($_ as element()) as xs:string? {$_/logo },
       "name": function($_ as element()) as xs:string {$_/name },
       "uri": function($_ as element()) as xs:string? {$_/('/' || name) },
       "version": function($_ as element()) as xs:string {$_/version } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/description)
                        return if($d)
                              then element description {  $d } 
                              else () },
           "logo": function($_ as element()) as element(logo)? {
            (: string :)
                        let $d:=fn:data($_/logo)
                        return if($d)
                              then element logo {  $d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/name)
                        return if($d)
                              then element name {  $d } 
                              else () },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        let $d:=fn:data($_/('/' || name))
                        return if($d)
                              then element uri {  $d } 
                              else () },
           "version": function($_ as element()) as element(version)? {
            (: string :)
                        let $d:=fn:data($_/version)
                        return if($d)
                              then element version {  $d } 
                              else () } },
      "data": function() as element(item)*
       { () }
   },
  "component.version": map{
     "name": "component.version",
     "description": "A specific version of a component.",
     "access": map{ 
       "component": function($_ as element()) as xs:string {$_/@name },
       "found": function($_ as element()) as xs:boolean {$_/@found },
       "status": function($_ as element()) as xs:string {$_/@status },
       "version": function($_ as element()) as xs:string {$_/@version } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "component": function($_ as element()) as element(component)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element component {  $d } 
                              else () },
           "found": function($_ as element()) as element(found)? {
            (: boolean :)
                        let $d:=fn:data($_/@found)
                        return if($d)
                              then element found { attribute type {'boolean'}, $d } 
                              else () },
           "status": function($_ as element()) as element(status)? {
            (: string :)
                        let $d:=fn:data($_/@status)
                        return if($d)
                              then element status {  $d } 
                              else () },
           "version": function($_ as element()) as element(version)? {
            (: string :)
                        let $d:=fn:data($_/@version)
                        return if($d)
                              then element version {  $d } 
                              else () } },
      "data": function() as element(pkg:dependency)*
       { for $r in $cmpx:comps/comp:release
return <pkg:dependency  name="{$r/../@name}" version="{$r/@version}" found="true" status="ok"/> }
   },
  "component": map{
     "name": "component",
     "description": "A software component. Includes Javascript libraries 
		and EXPath packages. Components are managed through the qd-cmpx component.",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/comp:description },
       "home": function($_ as element()) as xs:string {$_/comp:home },
       "html": function($_ as element()) as element() {$_/. },
       "name": function($_ as element()) as xs:string {$_/@name },
       "releases": function($_ as element()) as xs:integer {$_/count(comp:release) },
       "type": function($_ as element()) as xs:string {$_/comp:type } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@name, $item/comp:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/comp:description)
                        return if($d)
                              then element description {  $d } 
                              else () },
           "home": function($_ as element()) as element(home)? {
            (: string :)
                        let $d:=fn:data($_/comp:home)
                        return if($d)
                              then element home {  $d } 
                              else () },
           "html": function($_ as element()) as element(html)? {
            element html { attribute type {"string"},fn:serialize($_/.)} },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element name {  $d } 
                              else () },
           "releases": function($_ as element()) as element(releases)? {
            (: number :)
                        let $d:=fn:data($_/count(comp:release))
                        return if($d)
                              then element releases { attribute type {'number'}, $d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/comp:type)
                        return if($d)
                              then element type {  $d } 
                              else () } },
      "data": function() as element(comp:cmp)*
       { $cmpx:comps }
   },
  "endpoint": map{
     "name": "endpoint",
     "description": "A WADL type wadl:resource",
     "access": map{ 
       "doc": function($_ as element()) as xs:string {$_/(if(wadl:method/wadl:doc) 
			       then wadl:method/wadl:doc/text()
			       else '' ) },
       "mediatype": function($_ as element()) as xs:string {$_/wadl:method/wadl:response/wadl:representation/@mediaType },
       "method": function($_ as element()) as xs:string {$_/wadl:method/@name },
       "path": function($_ as element()) as xs:string {$_/@path } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@path, $item/(if(wadl:method/wadl:doc) 
			       then wadl:method/wadl:doc/text()
			       else '' )) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "doc": function($_ as element()) as element(doc)? {
            (: string :)
                        let $d:=fn:data($_/(if(wadl:method/wadl:doc) 
			       then wadl:method/wadl:doc/text()
			       else '' ))
                        return if($d)
                              then element doc {  $d } 
                              else () },
           "mediatype": function($_ as element()) as element(mediatype)? {
            (: string :)
                        let $d:=fn:data($_/wadl:method/wadl:response/wadl:representation/@mediaType)
                        return if($d)
                              then element mediatype {  $d } 
                              else () },
           "method": function($_ as element()) as element(method)? {
            (: string :)
                        let $d:=fn:data($_/wadl:method/@name)
                        return if($d)
                              then element method {  $d } 
                              else () },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        let $d:=fn:data($_/@path)
                        return if($d)
                              then element path {  $d } 
                              else () } },
      "data": function() as element(wadl:resource)*
       { () }
   },
  "entity.field": map{
     "name": "entity.field",
     "description": "About an entity field.",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/ent:description },
       "name": function($_ as element()) as xs:string {$_/@name },
       "parent": function($_ as element()) as xs:string {$_/../../@name },
       "type": function($_ as element()) as xs:string {$_/@type },
       "xpath": function($_ as element()) as xs:string {$_/ent:xpath } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/ent:description)
                        return if($d)
                              then element description {  $d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element name {  $d } 
                              else () },
           "parent": function($_ as element()) as element(parent)? {
            (: string :)
                        let $d:=fn:data($_/../../@name)
                        return if($d)
                              then element parent {  $d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/@type)
                        return if($d)
                              then element type {  $d } 
                              else () },
           "xpath": function($_ as element()) as element(xpath)? {
            (: string :)
                        let $d:=fn:data($_/ent:xpath)
                        return if($d)
                              then element xpath {  $d } 
                              else () } },
      "data": function() as element(ent:field)*
       { collection("doc-doc")//ent:field }
   },
  "entity": map{
     "name": "entity",
     "description": "About an entity i.e. something described in this framework",
     "access": map{ 
       "code": function($_ as element()) as xs:string? {$_/ent:data },
       "description": function($_ as element()) as xs:string {$_/ent:description },
       "fieldslink": function($_ as element()) as xs:string {$_/fn:concat("/data/entity/",@name,"/field") },
       "iconclass": function($_ as element()) as xs:string {$_/ent:iconclass },
       "modules": function($_ as element()) as xs:string? {$_/ent:module/concat("import module namespace ",@prefix,"='",@namespace,"';
")=>string-join() },
       "name": function($_ as element()) as xs:string {$_/@name },
       "namespaces": function($_ as element()) as xs:string? {$_/ent:namespace/concat("declare namespace ",@prefix,"='",@uri,"';
")=>string-join() },
       "nfields": function($_ as element()) as xs:integer {$_/fn:count(ent:fields/ent:field) },
       "parent": function($_ as element()) as xs:string? {$_/ent:parent/@name },
       "parentlink": function($_ as element()) as xs:string? {$_/fn:concat("/data/entity/",ent:parent/@name) },
       "type": function($_ as element()) as xs:string {$_/ent:data/@type } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "code": function($_ as element()) as element(code)? {
            (: string :)
                        let $d:=fn:data($_/ent:data)
                        return if($d)
                              then element code {  $d } 
                              else () },
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/ent:description)
                        return if($d)
                              then element description {  $d } 
                              else () },
           "fieldslink": function($_ as element()) as element(fieldslink)? {
            (: string :)
                        let $d:=fn:data($_/fn:concat("/data/entity/",@name,"/field"))
                        return if($d)
                              then element fieldslink {  $d } 
                              else () },
           "iconclass": function($_ as element()) as element(iconclass)? {
            (: string :)
                        let $d:=fn:data($_/ent:iconclass)
                        return if($d)
                              then element iconclass {  $d } 
                              else () },
           "modules": function($_ as element()) as element(modules)? {
            (: string :)
                        let $d:=fn:data($_/ent:module/concat("import module namespace ",@prefix,"='",@namespace,"';
")=>string-join())
                        return if($d)
                              then element modules {  $d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/@name)
                        return if($d)
                              then element name {  $d } 
                              else () },
           "namespaces": function($_ as element()) as element(namespaces)? {
            (: string :)
                        let $d:=fn:data($_/ent:namespace/concat("declare namespace ",@prefix,"='",@uri,"';
")=>string-join())
                        return if($d)
                              then element namespaces {  $d } 
                              else () },
           "nfields": function($_ as element()) as element(nfields)? {
            (: number :)
                        let $d:=fn:data($_/fn:count(ent:fields/ent:field))
                        return if($d)
                              then element nfields { attribute type {'number'}, $d } 
                              else () },
           "parent": function($_ as element()) as element(parent)? {
            (: string :)
                        let $d:=fn:data($_/ent:parent/@name)
                        return if($d)
                              then element parent {  $d } 
                              else () },
           "parentlink": function($_ as element()) as element(parentlink)? {
            (: string :)
                        let $d:=fn:data($_/fn:concat("/data/entity/",ent:parent/@name))
                        return if($d)
                              then element parentlink {  $d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/ent:data/@type)
                        return if($d)
                              then element type {  $d } 
                              else () } },
      "data": function() as element(ent:entity)*
       { collection("doc-doc")//ent:entity }
   },
  "search-result": map{
     "name": "search-result",
     "description": "About a search result.",
     "access": map{ 
       "sref": function($_ as element()) as xs:string {$_/"app.item.index({'name':'benchx'})" },
       "title": function($_ as element()) as xs:string {$_/title },
       "type": function($_ as element()) as xs:string {$_/type },
       "uri": function($_ as element()) as xs:string {$_/uri } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "sref": function($_ as element()) as element(sref)? {
            (: string :)
                        let $d:=fn:data($_/"app.item.index({'name':'benchx'})")
                        return if($d)
                              then element sref {  $d } 
                              else () },
           "title": function($_ as element()) as element(title)? {
            (: string :)
                        let $d:=fn:data($_/title)
                        return if($d)
                              then element title {  $d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/type)
                        return if($d)
                              then element type {  $d } 
                              else () },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        let $d:=fn:data($_/uri)
                        return if($d)
                              then element uri {  $d } 
                              else () } },
      "data": function() as element(search)*
       { () }
   },
  "task": map{
     "name": "task",
     "description": "A piece of runnable XQuery code that causes side effects",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:comment/xqdoc:description },
       "name": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:uri },
       "params": function($_ as element()) as xs:integer {$_/count(.//xqdoc:variable) },
       "path": function($_ as element()) as xs:string {$_/fn:replace(db:path(.),"^modules/","doc/") },
       "xquery": function($_ as element()) as xs:string {$_/concat('/doc/data/file/read?path=' ,db:path(.)) } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/xqdoc:module/xqdoc:uri, $item/xqdoc:module/xqdoc:comment/xqdoc:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)
                        return if($d)
                              then element description {  $d } 
                              else () },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:uri)
                        return if($d)
                              then element name {  $d } 
                              else () },
           "params": function($_ as element()) as element(params)? {
            (: number :)
                        let $d:=fn:data($_/count(.//xqdoc:variable))
                        return if($d)
                              then element params { attribute type {'number'}, $d } 
                              else () },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        let $d:=fn:data($_/fn:replace(db:path(.),"^modules/","doc/"))
                        return if($d)
                              then element path {  $d } 
                              else () },
           "xquery": function($_ as element()) as element(xquery)? {
            (: string :)
                        let $d:=fn:data($_/concat('/doc/data/file/read?path=' ,db:path(.)))
                        return if($d)
                              then element xquery {  $d } 
                              else () } },
      "data": function() as element(xqdoc:xqdoc)*
       { collection("doc-doc")//xqdoc:xqdoc[
  xqdoc:namespaces/xqdoc:namespace/@uri="https://github.com/Quodatum/app-doc/task"
 and xqdoc:module/@type="main"
] }
   },
  "xqmodule": map{
     "name": "xqmodule",
     "description": "An XQuery source code module",
     "access": map{ 
       "dbpath": function($_ as element()) as xs:string {$_/db:path(.) },
       "description": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:comment/xqdoc:description },
       "filename": function($_ as element()) as xs:string {$_/tokenize(base-uri(.),"/")[last()] },
       "href": function($_ as element()) as xs:string {$_/("#/data/xqmodule/item?item=" || db:path(.)) },
       "html": function($_ as element()) as element() {$_/xqdoc-html:create(.,"path",true()) },
       "name": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:name },
       "path": function($_ as element()) as xs:string {$_/(
            if(starts-with(db:path(.),"basex.xqm/"))
            then "doc/data/" || db:path(.)
            else "doc/" || substring-after(db:path(.),"modules/")
            ) },
       "type": function($_ as element()) as xs:string {$_/(if(starts-with(db:path(.),"basex.xqm/"))
			        then "basex" 
			        else xqdoc:module/@type) },
       "uri": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:uri } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/xqdoc:module/xqdoc:comment/xqdoc:description, $item/xqdoc:module/xqdoc:name) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "dbpath": function($_ as element()) as element(dbpath)? {
            (: string :)
                        let $d:=fn:data($_/db:path(.))
                        return if($d)
                              then element dbpath {  $d } 
                              else () },
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)
                        return if($d)
                              then element description {  $d } 
                              else () },
           "filename": function($_ as element()) as element(filename)? {
            (: string :)
                        let $d:=fn:data($_/tokenize(base-uri(.),"/")[last()])
                        return if($d)
                              then element filename {  $d } 
                              else () },
           "href": function($_ as element()) as element(href)? {
            (: string :)
                        let $d:=fn:data($_/("#/data/xqmodule/item?item=" || db:path(.)))
                        return if($d)
                              then element href {  $d } 
                              else () },
           "html": function($_ as element()) as element(html)? {
            element html { attribute type {"string"},fn:serialize($_/xqdoc-html:create(.,"path",true()))} },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:name)
                        return if($d)
                              then element name {  $d } 
                              else () },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        let $d:=fn:data($_/(
            if(starts-with(db:path(.),"basex.xqm/"))
            then "doc/data/" || db:path(.)
            else "doc/" || substring-after(db:path(.),"modules/")
            ))
                        return if($d)
                              then element path {  $d } 
                              else () },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        let $d:=fn:data($_/(if(starts-with(db:path(.),"basex.xqm/"))
			        then "basex" 
			        else xqdoc:module/@type))
                        return if($d)
                              then element type {  $d } 
                              else () },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        let $d:=fn:data($_/xqdoc:module/xqdoc:uri)
                        return if($d)
                              then element uri {  $d } 
                              else () } },
      "data": function() as element(xqdoc:xqdoc)*
       { collection("doc-doc")/xqdoc:xqdoc }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  