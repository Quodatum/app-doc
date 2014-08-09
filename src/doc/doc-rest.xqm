(:~ 
 : A RESTXQ interface for documentation
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace bm = 'apb.doc.rest';
declare default function namespace 'apb.doc.rest'; 

import module namespace doc = 'apb.doc' at 'lib.xq/doctools.xqm';
import module namespace web = 'apb.web.utils3' at 'lib.xq/webutils.xqm';

(:~
 : The doc api
 :)
declare 
 %output:method("html")
 %output:version("5.0")
%rest:GET %rest:path("doc/{$app}")
function app($app as xs:string) 
{
   <div>
   <a href="{$app}/server/xqdoc">Xquery doc for application</a>
   <a href="{$app}/server/wadl">WADL doc for application</a>
   <a href="{$app}/client/components">Client side components used by the application</a>
   <a href="{$app}/client/templates">XML templates  for application</a>     
   </div>
};
(:~
 : show xqdoc for rest api
 :)
declare 
%rest:GET %rest:path("doc/{$app}/server/xqdoc")

%restxq:query-param("mod", "{$mod}","benchx-rest.xqm")
%restxq:query-param("fmt", "{$fmt}","html")   
function xqdoc($app as xs:string,
                $mod as xs:string,
                $fmt as xs:string) 
{
    let $src:=fn:resolve-uri(fn:concat("../",$app,"/",$mod))
    let $mod:=fn:trace($mod,"mod::::")
    let $doc:=inspect:xqdoc($src)
    let $r:=if($fmt="html") then doc:generate-html($doc) else $doc
    return (web:method($fmt),$r)
};
 
(:~
 : show xqdoc for rest api
 :)
declare 
%rest:GET %rest:path("doc/{$app}/server/wadl")
%output:method("html")  
function wadl($app as xs:string) 
{
  doc:wadl("/" || $app) 
}; 

(:~
 : show client javascript components 
 :)
declare 
%rest:GET %rest:path("doc/{$app}/client/components")
%output:method("html")  
function client-components($app as xs:string) 
{
  let $src:="../" || $app || "/components.xml"
  let $r:=xslt:transform(fn:doc($src), fn:doc("component.xsl"))  
  return $r 
}; 

(:~
 : show list templates
 :)
declare 
%rest:GET %rest:path("doc/{$app}/client/templates")
%output:method("html")  
function templates($app as xs:string) 
{
  <todo>Yes</todo>
}; 