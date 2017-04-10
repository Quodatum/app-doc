(: entity access maps 
 : auto generated from xml files in entities folder at: 2017-03-06T12:42:40.42Z 
 :)

module namespace entity = 'quodatum.models.generated';
import module namespace cmpx='quodatum.cmpx';
import module namespace rest='http://exquery.org/ns/restxq';
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
            (: xs:string? :)
                        fn:data($_/description)!element description {  .} 
                 },
           "logo": function($_ as element()) as element(logo)? {
            (: xs:string? :)
                        fn:data($_/logo)!element logo {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/name)!element name {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: xs:string? :)
                        fn:data($_/('/' || name))!element uri {  .} 
                 },
           "version": function($_ as element()) as element(version)? {
            (: xs:string :)
                        fn:data($_/version)!element version {  .} 
                 } },
       
      "data": function() as element(item)*
       { () },
       
       "views": map{ 
       'id': 'name','list': 'name version description uri logo','filter': 'name description'
       }
   },
  "basexlog": map{
     "name": "basexlog",
     "description": "BaseX log entry",
     "access": map{ 
       "address": function($_ as element()) as xs:string {$_/@address },
       "text": function($_ as element()) as xs:string {$_/. },
       "time": function($_ as element()) as xs:string {$_/@time },
       "type": function($_ as element()) as xs:string {$_/@type },
       "user": function($_ as element()) as xs:string {$_/@user } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( ) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "address": function($_ as element()) as element(address)? {
            (: xs:string :)
                        fn:data($_/@address)!element address {  .} 
                 },
           "text": function($_ as element()) as element(text)? {
            (: xs:string :)
                        fn:data($_/.)!element text {  .} 
                 },
           "time": function($_ as element()) as element(time)? {
            (: xs:string :)
                        fn:data($_/@time)!element time {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: xs:string :)
                        fn:data($_/@user)!element user {  .} 
                 } },
       
      "data": function() as element(entry)*
       { admin:logs()!admin:logs(.,true()) },
       
       "views": map{ 
       
       }
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
            (: xs:string :)
                        fn:data($_/@name)!element component {  .} 
                 },
           "found": function($_ as element()) as element(found)? {
            (: xs:boolean :)
                        fn:data($_/@found)!element found { attribute type {'boolean'}, .} 
                 },
           "status": function($_ as element()) as element(status)? {
            (: xs:string :)
                        fn:data($_/@status)!element status {  .} 
                 },
           "version": function($_ as element()) as element(version)? {
            (: xs:string :)
                        fn:data($_/@version)!element version {  .} 
                 } },
       
      "data": function() as element(pkg:dependency)*
       { for $r in cmpx:comps()/comp:release
return <pkg:dependency  name="{$r/../@name}" version="{$r/@version}" found="true" status="ok"/> },
       
       "views": map{ 
       'filter': 'component'
       }
   },
  "component": map{
     "name": "component",
     "description": "A software component. Includes Javascript libraries
		and EXPath packages. Components are managed through the qd-cmpx
		component.",
     "access": map{ 
       "dependencies": function($_ as element()) as xs:integer {$_/count(comp:dependency) },
       "dependency": function($_ as element()) as xs:string* {$_/comp:dependency/@name/string() },
       "description": function($_ as element()) as xs:string {$_/comp:description },
       "home": function($_ as element()) as xs:string {$_/comp:home },
       "html": function($_ as element()) as element() {$_/. },
       "name": function($_ as element()) as xs:string {$_/@name },
       "release": function($_ as element()) as xs:string* {$_/comp:release/@version/string() },
       "releases": function($_ as element()) as xs:integer {$_/count(comp:release) },
       "type": function($_ as element()) as xs:string {$_/comp:type } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/@name, $item/comp:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "dependencies": function($_ as element()) as element(dependencies)? {
            (: xs:integer :)
                        fn:data($_/count(comp:dependency))!element dependencies { attribute type {'number'}, .} 
                 },
           "dependency": function($_ as element()) as element(dependency)* {
            (: array of strings :)
                   element dependency { 
                        attribute type {"array"},
                        $_/comp:dependency/@name/string()!element _ { attribute type {"string"}, .}
                        } 
                 },
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/comp:description)!element description {  .} 
                 },
           "home": function($_ as element()) as element(home)? {
            (: xs:string :)
                        fn:data($_/comp:home)!element home {  .} 
                 },
           "html": function($_ as element()) as element(html)? {
            element html { 
                     attribute type {"string"},
                     fn:serialize($_/.)} },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "release": function($_ as element()) as element(release)* {
            (: array of strings :)
                   element release { 
                        attribute type {"array"},
                        $_/comp:release/@version/string()!element _ { attribute type {"string"}, .}
                        } 
                 },
           "releases": function($_ as element()) as element(releases)? {
            (: xs:integer :)
                        fn:data($_/count(comp:release))!element releases { attribute type {'number'}, .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/comp:type)!element type {  .} 
                 } },
       
      "data": function() as element(comp:cmp)*
       { cmpx:comps() },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "database": map{
     "name": "database",
     "description": "A BaseX database",
     "access": map{ 
       "collection": function($_ as element()) as xs:string {$_/(. || "/") },
       "href": function($_ as element()) as xs:string {$_/("#/data/database/" || .) },
       "modifiedDate": function($_ as element()) as xs:dateTime {$_/@modified-date },
       "name": function($_ as element()) as xs:string {$_/. },
       "path": function($_ as element()) as xs:string {$_/@path },
       "resources": function($_ as element()) as xs:integer {$_/@resources },
       "size": function($_ as element()) as xs:integer {$_/@size } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/.) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "collection": function($_ as element()) as element(collection)? {
            (: xs:string :)
                        fn:data($_/(. || "/"))!element collection {  .} 
                 },
           "href": function($_ as element()) as element(href)? {
            (: xs:string :)
                        fn:data($_/("#/data/database/" || .))!element href {  .} 
                 },
           "modifiedDate": function($_ as element()) as element(modifiedDate)? {
            (: xs:dateTime :)
                        fn:data($_/@modified-date)!element modifiedDate {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/.)!element name {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: xs:string :)
                        fn:data($_/@path)!element path {  .} 
                 },
           "resources": function($_ as element()) as element(resources)? {
            (: xs:integer :)
                        fn:data($_/@resources)!element resources { attribute type {'number'}, .} 
                 },
           "size": function($_ as element()) as element(size)? {
            (: xs:integer :)
                        fn:data($_/@size)!element size { attribute type {'number'}, .} 
                 } },
       
      "data": function() as element(database)*
       { db:list-details() },
       
       "views": map{ 
       'filter': 'name'
       }
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
            (: xs:string :)
                        fn:data($_/(if(wadl:method/wadl:doc) 
			       then wadl:method/wadl:doc/text()
			       else '' ))!element doc {  .} 
                 },
           "mediatype": function($_ as element()) as element(mediatype)? {
            (: xs:string :)
                        fn:data($_/wadl:method/wadl:response/wadl:representation/@mediaType)!element mediatype {  .} 
                 },
           "method": function($_ as element()) as element(method)? {
            (: xs:string :)
                        fn:data($_/wadl:method/@name)!element method {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: xs:string :)
                        fn:data($_/@path)!element path {  .} 
                 } },
       
      "data": function() as element(wadl:resource)*
       { fn:trace(rest:wadl(),"WADL")//wadl:resource },
       
       "views": map{ 
       'filter': 'path doc'
       }
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
            (: xs:string :)
                        fn:data($_/ent:description)!element description {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "parent": function($_ as element()) as element(parent)? {
            (: xs:string :)
                        fn:data($_/../../@name)!element parent {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "xpath": function($_ as element()) as element(xpath)? {
            (: xs:string :)
                        fn:data($_/ent:xpath)!element xpath {  .} 
                 } },
       
      "data": function() as element(ent:field)*
       { collection("doc-doc")//ent:field },
       
       "views": map{ 
       'filter': 'name description'
       }
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
            (: xs:string? :)
                        fn:data($_/ent:data)!element code {  .} 
                 },
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/ent:description)!element description {  .} 
                 },
           "fieldslink": function($_ as element()) as element(fieldslink)? {
            (: xs:string :)
                        fn:data($_/fn:concat("/data/entity/",@name,"/field"))!element fieldslink {  .} 
                 },
           "iconclass": function($_ as element()) as element(iconclass)? {
            (: xs:string :)
                        fn:data($_/ent:iconclass)!element iconclass {  .} 
                 },
           "modules": function($_ as element()) as element(modules)? {
            (: xs:string? :)
                        fn:data($_/ent:module/concat("import module namespace ",@prefix,"='",@namespace,"';
")=>string-join())!element modules {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/@name)!element name {  .} 
                 },
           "namespaces": function($_ as element()) as element(namespaces)? {
            (: xs:string? :)
                        fn:data($_/ent:namespace/concat("declare namespace ",@prefix,"='",@uri,"';
")=>string-join())!element namespaces {  .} 
                 },
           "nfields": function($_ as element()) as element(nfields)? {
            (: xs:integer :)
                        fn:data($_/fn:count(ent:fields/ent:field))!element nfields { attribute type {'number'}, .} 
                 },
           "parent": function($_ as element()) as element(parent)? {
            (: xs:string? :)
                        fn:data($_/ent:parent/@name)!element parent {  .} 
                 },
           "parentlink": function($_ as element()) as element(parentlink)? {
            (: xs:string? :)
                        fn:data($_/fn:concat("/data/entity/",ent:parent/@name))!element parentlink {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/ent:data/@type)!element type {  .} 
                 } },
       
      "data": function() as element(ent:entity)*
       { collection("doc-doc")//ent:entity },
       
       "views": map{ 
       'filter': 'name description'
       }
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
            (: xs:string :)
                        fn:data($_/name)!element name {  .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: xs:string :)
                        fn:data($_/path)!element path {  .} 
                 } },
       
      "data": function() as element(*)*
       { () },
       
       "views": map{ 
       'filter': 'name'
       }
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
            (: xs:string :)
                        fn:data($_/@duration)!element duration {  .} 
                 },
           "id": function($_ as element()) as element(id)? {
            (: xs:string :)
                        fn:data($_/@id)!element id {  .} 
                 },
           "state": function($_ as element()) as element(state)? {
            (: xs:string :)
                        fn:data($_/@state)!element state {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/@type)!element type {  .} 
                 },
           "user": function($_ as element()) as element(user)? {
            (: xs:string :)
                        fn:data($_/@user)!element user {  .} 
                 } },
       
      "data": function() as element(job)*
       { jobs:list()[. != jobs:current()]  ! jobs:list-details(.) },
       
       "views": map{ 
       'filter': 'name description'
       }
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
            (: xs:string :)
                        fn:data($_/"app.item.index({'name':'benchx'})")!element sref {  .} 
                 },
           "title": function($_ as element()) as element(title)? {
            (: xs:string :)
                        fn:data($_/title)!element title {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/type)!element type {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: xs:string :)
                        fn:data($_/uri)!element uri {  .} 
                 } },
       
      "data": function() as element(search)*
       { () },
       
       "views": map{ 
       
       }
   },
  "task": map{
     "name": "task",
     "description": "A piece of runnable XQuery code that causes side effects",
     "access": map{ 
       "description": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:comment/xqdoc:description },
       "name": function($_ as element()) as xs:string {$_/xqdoc:module/xqdoc:uri },
       "params": function($_ as element()) as xs:integer {$_/count(descendant::xqdoc:variable) },
       "path": function($_ as element()) as xs:string {$_/fn:replace(db:path(.),"^modules/","doc/") },
       "url": function($_ as element()) as xs:string {$_/fn:replace(db:path(.),'^apps/','') } },
    
     "filter": function($item,$q) as xs:boolean{ 
         some $e in ( $item/xqdoc:module/xqdoc:uri, $item/xqdoc:module/xqdoc:comment/xqdoc:description) satisfies
         fn:contains($e,$q, 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive')
      },
       "json":   map{ 
           "description": function($_ as element()) as element(description)? {
            (: xs:string :)
                        fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)!element description {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string :)
                        fn:data($_/xqdoc:module/xqdoc:uri)!element name {  .} 
                 },
           "params": function($_ as element()) as element(params)? {
            (: xs:integer :)
                        fn:data($_/count(descendant::xqdoc:variable))!element params { attribute type {'number'}, .} 
                 },
           "path": function($_ as element()) as element(path)? {
            (: xs:string :)
                        fn:data($_/fn:replace(db:path(.),"^modules/","doc/"))!element path {  .} 
                 },
           "url": function($_ as element()) as element(url)? {
            (: xs:string :)
                        fn:data($_/fn:replace(db:path(.),'^apps/',''))!element url {  .} 
                 } },
       
      "data": function() as element(xqdoc:xqdoc)*
       { collection("doc-doc")//xqdoc:xqdoc[
  xqdoc:namespaces/xqdoc:namespace/@uri="https://github.com/Quodatum/app-doc/task"
 and xqdoc:module/@type="main"
] },
       
       "views": map{ 
       'filter': 'name description'
       }
   },
  "xqmodule": map{
     "name": "xqmodule",
     "description": "An XQuery source code module",
     "access": map{ 
       "app": function($_ as element()) as xs:string? {$_/(if(fn:starts-with(db:path(.),"apps/"))then fn:tokenize(db:path(.),"/")[2] else "") },
       "dbpath": function($_ as element()) as xs:string {$_/db:path(.) },
       "description": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:comment/xqdoc:description },
       "filename": function($_ as element()) as xs:string {$_/tokenize(base-uri(.),"/")[last()] },
       "href": function($_ as element()) as xs:string {$_/("#/data/xqmodule/item?item=" || db:path(.)) },
       "html": function($_ as element()) as element() {$_/xqdoc-html:create(.,"path",true()) },
       "icon": function($_ as element()) as xs:string? {$_/"./icon.svg" },
       "name": function($_ as element()) as xs:string? {$_/xqdoc:module/xqdoc:name },
       "srcpath": function($_ as element()) as xs:string {$_/(
            if(starts-with(db:path(.),"basex.xqm/"))
            then "doc/data/" || db:path(.)
            else  substring-after(db:path(.),"apps/")
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
           "app": function($_ as element()) as element(app)? {
            (: xs:string? :)
                        fn:data($_/(if(fn:starts-with(db:path(.),"apps/"))then fn:tokenize(db:path(.),"/")[2] else ""))!element app {  .} 
                 },
           "dbpath": function($_ as element()) as element(dbpath)? {
            (: xs:string :)
                        fn:data($_/db:path(.))!element dbpath {  .} 
                 },
           "description": function($_ as element()) as element(description)? {
            (: xs:string? :)
                        fn:data($_/xqdoc:module/xqdoc:comment/xqdoc:description)!element description {  .} 
                 },
           "filename": function($_ as element()) as element(filename)? {
            (: xs:string :)
                        fn:data($_/tokenize(base-uri(.),"/")[last()])!element filename {  .} 
                 },
           "href": function($_ as element()) as element(href)? {
            (: xs:string :)
                        fn:data($_/("#/data/xqmodule/item?item=" || db:path(.)))!element href {  .} 
                 },
           "html": function($_ as element()) as element(html)? {
            element html { 
                     attribute type {"string"},
                     fn:serialize($_/xqdoc-html:create(.,"path",true()))} },
           "icon": function($_ as element()) as element(icon)? {
            (: xs:string? :)
                        fn:data($_/"./icon.svg")!element icon {  .} 
                 },
           "name": function($_ as element()) as element(name)? {
            (: xs:string? :)
                        fn:data($_/xqdoc:module/xqdoc:name)!element name {  .} 
                 },
           "srcpath": function($_ as element()) as element(srcpath)? {
            (: xs:string :)
                        fn:data($_/(
            if(starts-with(db:path(.),"basex.xqm/"))
            then "doc/data/" || db:path(.)
            else  substring-after(db:path(.),"apps/")
            ))!element srcpath {  .} 
                 },
           "type": function($_ as element()) as element(type)? {
            (: xs:string :)
                        fn:data($_/(if(starts-with(db:path(.),"basex.xqm/"))
			        then "basex" 
			        else xqdoc:module/@type))!element type {  .} 
                 },
           "uri": function($_ as element()) as element(uri)? {
            (: xs:string? :)
                        fn:data($_/xqdoc:module/xqdoc:uri)!element uri {  .} 
                 } },
       
      "data": function() as element(xqdoc:xqdoc)*
       { collection("doc-doc")/xqdoc:xqdoc },
       
       "views": map{ 
       'id': 'dbpath','list': 'name html','filter': 'name description'
       }
   }
};

 

(:~ map of access functions for entity :)
declare function entity:fields($entity as xs:string)
as map(*){
  $entity:list($entity)("access")
}; 
  