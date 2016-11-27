xquery version "3.0";
(:~
: info about an app
:
: @copyright quodatum ltd
: @author andy bunce
: @since may 2014
: @licence apache 2
:)
 
module namespace doc = 'quodatum.doc.apps';
declare default function namespace 'quodatum.doc.apps';
declare namespace cxan="http://cxan.org/ns/package";
declare namespace pkg="http://expath.org/ns/pkg";
declare variable $doc:insensitive:= 'http://www.w3.org/2005/xpath-functions/collation/html-ascii-case-insensitive';

declare function filter-apps($apps as element()*,$q as xs:string){
  $apps[some $e in (name,description)satisfies  fn:contains($e,$q,$doc:insensitive)]
};

(:~ 
 :detail of app
 :)
declare function app-json($app as xs:string,$resolver as function(*)) as element(item){
    let $cxanurl:=$resolver("app",$app,"cxan.xml")
    let $pkgurl:=$resolver("app",$app,"expath-pkg.xml")
    let $version:=if(fn:doc-available($pkgurl)) then fn:doc($pkgurl)/pkg:package/@version/fn:string() else "?"
    let $cxan:=fn:doc(if(fn:doc-available($cxanurl)) then $cxanurl else "cxan-missing.xml")
    let $logo:=$resolver("static",$app,"logo.svg")
    let $logo:= if(file:exists($logo))
                then <logo>{"/static/" || $app || "/logo.svg"}</logo> 
                else <logo>{"/static/" || "doc" || "/nologo.svg"}</logo> 
    let $desc:=$cxan/cxan:package/cxan:abstract/fn:string()      
     return <item type="object">
                    <name>{$app}</name>
                    <description>{$desc}</description>
                    <version>{$version}</version>
                    {$logo
                    }</item>            
};

