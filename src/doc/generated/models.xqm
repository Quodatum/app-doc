(: entity access maps 
 : auto generated from xml files in entities folder at: 2016-11-05T23:08:39.501Z 
 :)

module namespace entity = 'quodatum.models.generated';
import module namespace cmpx='quodatum.cmpx';
import module namespace xqdoc-html='quodatum.xqdoc.html';
declare namespace pkg='http://expath.org/ns/pkg';
declare namespace comp='urn:quodatum:qd-cmpx:component';
declare namespace wadl='http://wadl.dev.java.net/2009/02';
declare namespace ent='https://github.com/Quodatum/app-doc/entity';
declare namespace c='http://www.w3.org/ns/xproc-step';
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
         some $e in ( $item/name, $item/description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        fn:data($_/description)!element description {  .} 
                 },
           "logo": function($_ as element()) as element(logo)? {
            (: string :)
                        fn:data($_/logo)!element logo {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/name)!element name {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        fn:data($_/('/' || name))!element uri {  .} 
                 },
           "version": function($_ as element()) as element(version)? {
            (: string :)
                        fn:data($_/version)!element version {  .} 
                 } },
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
         some $e in ( $item/@name) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "component": function($_ as element()) as element(component)? {
            (: string :)
                        fn:data($_/@name)!element component {  .} 
                 },
           "found": function($_ as element()) as element(found)? {
            (: boolean :)
                        fn:data($_/@found)!element found { attribute type {'boolean'}, .} 
                 },
           "status": function($_ as element()) as element(status)? {
            (: string :)
                        fn:data($_/@status)!element status {  .} 
                 },
           "version": function($_ as element()) as element(version)? {
            (: string :)
                        fn:data($_/@version)!element version {  .} 
                 } },
      "data": function() as element(pkg:dependency)*
       { for $r in cmpx:comps()/comp:release
return <pkg:dependency  name="{$r/../@name}" version="{$r/@version}" found="true" status="ok"/> }
   },
  "component": map{
     "name": "component",
     "description": "A software component. Includes Javascript libraries
		and EXPath packages. Components are managed through the qd-cmpx
		component.",
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
                        fn:data($_/comp:description)!element description {  .} 
                 },
           "home": function($_ as element()) as element(home)? {
            (: string :)
                        fn:data($_/comp:home)!element home {  .} 
                 },
           "html": function($_ as element()) as element(html)? {
            element html { attribute type {"string"},fn:serialize($_/.)} },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "releases": function($_ as element()) as element(releases)? {
            (: number :)
                        fn:data($_/count(comp:release))!element releases { attribute type {'number'}, .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        fn:data($_/comp:type)!element type {  .} 
                 } },
      "data": function() as element(comp:cmp)*
       { cmpx:comps() }
   },
  "database": map{
     "name": "database",
     "description": "A BaseX database",
     "access": map{ 
       "href": function($_ as element()) as xs:string {$_/"#/data/database/" || . },
       "modifiedDate": function($_ as element()) as xs:dateTime {$_/@modified-date },
       "name": function($_ as element()) as xs:string {$_/. },
       "path": function($_ as element()) as xs:string {$_/@path },
       "resources": function($_ as element()) as xs:integer {$_/@resources } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "href": function($_ as element()) as element(href)? {
            (: string :)
                        fn:data($_/"#/data/database/" || .)!element href {  .} 
                 },
           "modifiedDate": function($_ as element()) as element(modifiedDate)? {
            (: string :)
                        fn:data($_/@modified-date)!element modifiedDate {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/.)!element name {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        fn:data($_/@path)!element path {  .} 
                 },
           "resources": function($_ as element()) as element(resources)? {
            (: number :)
                        fn:data($_/@resources)!element resources { attribute type {'number'}, .} 
                 } },
      "data": function() as element(database)*
       { db:list-details() }
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
                        fn:data($_/(if(wadl:method/wadl:doc) 
			       then wadl:method/wadl:doc/text()
			       else '' ))!element doc {  .} 
                 },
           "mediatype": function($_ as element()) as element(mediatype)? {
            (: string :)
                        fn:data($_/wadl:method/wadl:response/wadl:representation/@mediaType)!element mediatype {  .} 
                 },
           "method": function($_ as element()) as element(method)? {
            (: string :)
                        fn:data($_/wadl:method/@name)!element method {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        fn:data($_/@path)!element path {  .} 
                 } },
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
         some $e in ( $item/@name, $item/ent:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        fn:data($_/ent:description)!element description {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "parent": function($_ as element()) as element(parent)? {
            (: string :)
                        fn:data($_/../../@name)!element parent {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "xpath": function($_ as element()) as element(xpath)? {
            (: string :)
                        fn:data($_/ent:xpath)!element xpath {  .} 
                 } },
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
         some $e in ( $item/@name, $item/ent:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "code": function($_ as element()) as element(code)? {
            (: string :)
                        fn:data($_/ent:data)!element code {  .} 
                 },
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        fn:data($_/ent:description)!element description {  .} 
                 },
           "fieldslink": function($_ as element()) as element(fieldslink)? {
            (: string :)
                        fn:data($_/fn:concat("/data/entity/",@name,"/field"))!element fieldslink {  .} 
                 },
           "iconclass": function($_ as element()) as element(iconclass)? {
            (: string :)
                        fn:data($_/ent:iconclass)!element iconclass {  .} 
                 },
           "modules": function($_ as element()) as element(modules)? {
            (: string :)
                        fn:data($_/ent:module/concat("import module namespace ",@prefix,"='",@namespace,"';
")=>string-join())!element modules {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "namespaces": function($_ as element()) as element(namespaces)? {
            (: string :)
                        fn:data($_/ent:namespace/concat("declare namespace ",@prefix,"='",@uri,"';
")=>string-join())!element namespaces {  .} 
                 },
           "nfields": function($_ as element()) as element(nfields)? {
            (: number :)
                        fn:data($_/fn:count(ent:fields/ent:field))!element nfields { attribute type {'number'}, .} 
                 },
           "parent": function($_ as element()) as element(parent)? {
            (: string :)
                        fn:data($_/ent:parent/@name)!element parent {  .} 
                 },
           "parentlink": function($_ as element()) as element(parentlink)? {
            (: string :)
                        fn:data($_/fn:concat("/data/entity/",ent:parent/@name))!element parentlink {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        fn:data($_/ent:data/@type)!element type {  .} 
                 } },
      "data": function() as element(ent:entity)*
       { collection("doc-doc")//ent:entity }
   },
  "file": map{
     "name": "file",
     "description": "A file system element file or directory on the server.
	Based on XProc.",
     "access": map{ 
       "name": function($_ as element()) as xs:string {$_/name },
       "path": function($_ as element()) as xs:string {$_/path } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/name) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/name)!element name {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        fn:data($_/path)!element path {  .} 
                 } },
      "data": function() as element(*)*
       { () }
   },
  "job": map{
     "name": "job",
     "description": "a BaseX job",
     "access": map{ 
       "duration": function($_ as element()) as xs:string {$_/@duration },
       "id": function($_ as element()) as xs:string {$_/@id },
       "state": function($_ as element()) as xs:string {$_/@state },
       "type": function($_ as element()) as xs:string {$_/@type },
       "user": function($_ as element()) as xs:string {$_/@user } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "duration": function($_ as element()) as element(duration)? {
            (: string :)
                        fn:data($_/@duration)!element duration {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "state": function($_ as element()) as element(state)? {
            (: string :)
                        fn:data($_/@state)!element state {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: string :)
                        fn:data($_/@user)!element user {  .} 
                 } },
      "data": function() as element(job)*
       { jobs:list()[. != jobs:current()]  ! jobs:list-details(.) }
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
                        fn:data($_/"app.item.index({'name':'benchx'})")!element sref {  .} 
                 },
           "title": function($_ as element()) as element(title)? {
            (: string :)
                        fn:data($_/title)!element title {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        fn:data($_/type)!element type {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        fn:data($_/uri)!element uri {  .} 
                 } },
      "data": function() as element(search)*
       { () }
   },
  "task": map{
     "name": "task",
     "description": "A piece of runnable XQuery code that causes side effects",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:comment/xqdoc:description },
       "name": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:uri },
       "params": function($_ as element()) as xs:integer {$_/count(descendant::xqdoc:variable) },
       "path": function($_ as element()) as xs:string {$_/fn:replace(db:path(.),"^modules/","doc/") },
       "xquery": function($_ as element()) as xs:string {$_/concat('/doc/data/file/read?path=' ,db:path(.)) } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/xqdoc:module/xqdoc:uri, $item/xqdoc:module/xqdoc:comment/xqdoc:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)!element description {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/xqdoc:module/xqdoc:uri)!element name {  .} 
                 },
           "params": function($_ as element()) as element(params)? {
            (: number :)
                        fn:data($_/count(descendant::xqdoc:variable))!element params { attribute type {'number'}, .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        fn:data($_/fn:replace(db:path(.),"^modules/","doc/"))!element path {  .} 
                 },
           "xquery": function($_ as element()) as element(xquery)? {
            (: string :)
                        fn:data($_/concat('/doc/data/file/read?path=' ,db:path(.)))!element xquery {  .} 
                 } },
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
       "icon": function($_ as element()) as xs:string? {$_/"./icon.svg" },
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
                        fn:data($_/db:path(.))!element dbpath {  .} 
                 },
           "description": function($_ as element()) as element(description)? {
            (: string :)
                        fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)!element description {  .} 
                 },
           "filename": function($_ as element()) as element(filename)? {
            (: string :)
                        fn:data($_/tokenize(base-uri(.),"/")[last()])!element filename {  .} 
                 },
           "href": function($_ as element()) as element(href)? {
            (: string :)
                        fn:data($_/("#/data/xqmodule/item?item=" || db:path(.)))!element href {  .} 
                 },
           "html": function($_ as element()) as element(html)? {
            element html { attribute type {"string"},fn:serialize($_/xqdoc-html:create(.,"path",true()))} },
           "icon": function($_ as element()) as element(icon)? {
            (: string :)
                        fn:data($_/"./icon.svg")!element icon {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: string :)
                        fn:data($_/xqdoc:module/xqdoc:name)!element name {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: string :)
                        fn:data($_/(
            if(starts-with(db:path(.),"basex.xqm/"))
            then "doc/data/" || db:path(.)
            else "doc/" || substring-after(db:path(.),"modules/")
            ))!element path {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: string :)
                        fn:data($_/(if(starts-with(db:path(.),"basex.xqm/"))
			        then "basex" 
			        else xqdoc:module/@type))!element type {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: string :)
                        fn:data($_/xqdoc:module/xqdoc:uri)!element uri {  .} 
                 } },
      "data": function() as element(xqdoc:xqdoc)*
       { collection("doc-doc")/xqdoc:xqdoc }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  