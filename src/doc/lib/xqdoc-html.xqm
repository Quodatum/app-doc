(:~
 : This module generates single HTML documentation from an xqdoc source.
 :
 : based on original Christian Grün, BaseX Team, 2013
 :)
module namespace xqdoc-html = 'quodatum.xqdoc.html';
declare namespace xqdoc='http://www.xqdoc.org/1.0';
(:~ Supported tags. :)
declare variable $xqdoc-html:TAGS := ("description", "author", "version", "param",
  "error", "deprecated", "see", "since");
(:~
 : file paths below $src
 : $src typically from resolve-uri
 :)
 declare function xqdoc-html:files($src as xs:string,$recursive as xs:boolean, $pattern as xs:string) as xs:string*
 {
   fn:filter(file:list($src,$recursive, $pattern ),
          function ($f){file:is-file($src || $f)}
        )
 };

(:~
 : Creates a single HTML page for the specified module.
 :
 : @param  $path     path to query module
 : @param  $inspect  inspected module
 : @param  $private  also show private variables
 : @return body elements
 :)
declare function xqdoc-html:create(
  $xqdoc  as element(xqdoc:xqdoc),
  $path     as xs:string,
  $private  as xs:boolean)
  as node()*
{
  <h2>{
    $xqdoc/xqdoc:module/@type=>xqdoc-html:capitalize(),
    'Module:', replace($path, '^./', '')
  }</h2>,
  <table>{
    if(empty($xqdoc/xqdoc:module/xqdoc:uri)) then () else
    <tr>
      <td><b>URI:</b></td>
      <td><code>{ $xqdoc/xqdoc:module/xqdoc:uri/string() }</code></td>
    </tr>
   ,
      xqdoc-html:tags($xqdoc/xqdoc:module/xqdoc:comment[1])
      }
  </table>,

  xqdoc-html:variables($xqdoc, $private),
  xqdoc-html:functions($xqdoc, $private)
  (:,<h2>Source Documentation</h2>,<pre>{ serialize($inspect) }</pre>:)
};

(:~
 : Creates a description of all variables.
 :
 : @param  $inspect  information on the inspected module
 : @param  $private  also show private variables
 : @return description of variables
 :)
declare function xqdoc-html:variables(
  $xqdoc  as element(xqdoc:xqdoc),
  $private  as xs:boolean)
  as element()*
{
  let $variables := $xqdoc/xqdoc:variables/xqdoc:variable[
    $private or not(annotation/@name = 'private')
  ]
  where $variables
  return (
    <h2>Variables</h2>,
    <ul>{
      for $v at $p in $variables
      let $n := $v/@name/string()
      order by $n
      return <li><a href="#{ $n }">{ $n }</a></li>
    }</ul>,

    for $v at $p in $variables
    let $n := replace($v/@name, '.*:', '')
    order by $n
    let $link := replace($v/@name, '.*:', '')
    return (
      <h3 name="{ $link }">${ $n }</h3>,
      <table>{
        for $t in $v/@type/string()
        return <tr>
          <td><b>Type:</b></td>
          <td><code>{ $t }</code></td>
        </tr>
        ,xqdoc-html:tags($v/xqdoc:comment[1]) 
      }</table>
    )
  )
};

(:~
 : Creates a description of all functions.
 :
 : @param  $inspect  information on the inspected module
 : @param  $private  also show private functions
 : @return description of functions
 :)
declare function xqdoc-html:functions(
  $xqdoc  as element(xqdoc:xqdoc),
  $private  as xs:boolean)
  as element()*
{
  let $functions := $xqdoc/xqdoc:functions/xqdoc:function[
    $private or not(annotation/@name = 'private')
  ]
  let $signatures := $functions !xqdoc:signature
   
  where $functions
  return (
    <h2>Functions</h2>,
    for $f at $p in $functions
    let $s := $signatures[$p]/string()
    let $link := replace($f/xqdoc:name, '.*:', '') || '#' || $f/@arity
    order by $s
    return (
      <a name="{ $link }"><h3>{ $s }</h3></a>,
      <table>{
        let $args := $f/xqdoc:parameters where $args return
        <tr>
          <td><b>Arguments:</b></td>
          <td>
            <table>{
              for $a in $args
              return <tr>
                <td><code>${ $a/xqdoc:name/string() }</code></td>
                <td>{
                  let $t := $a/xqdoc:type || $a/@occurrence
                  where $t
                  return <code>{ $t }</code>
                }</td>
                <td>{ $a/node() }</td>
              </tr>
            }</table>
          </td>
        </tr>,

        let $return := $f/return
        where $return[@type|node()]
        return <tr>
          <td><b>Returns:</b></td>
          <td><table><tr>{
            let $t := $return/@type || $return/@occurrence
            where $t
            return <td><code>{ $t }</code></td>,
            <td>{ $return/node() }</td>
          }</tr></table></td>
        </tr>,

        for $throws in $f/tag[@name = 'throws']
        return <tr>
          <td><b>Throws:</b></td>
          <td>{ $throws/node() }</td>
        </tr>,

        let $annotations := $f/annotation
        where $annotations
        return <tr>
          <td><b>Annotations:</b></td>
          <td><table>{
            for $a in $annotations return (
              <tr><td><code>%{
                $a/@name ||
               (let $l := $a/literal
                where $l
                return '(' || string-join(
                  $l ! (if(@type = 'xs:string') then 
                    ('"' || . || '"') else .), ', ') || ')'
              )}</code></td></tr>
            )
          }</table></td>
        </tr>
    ,
      xqdoc-html:tags($f/xqdoc:comment[1]) 
      }</table>
    )
  )
};

(:~
 : Lists all supported tags from the specified node.
 : @param $node  root node
 : @return       tags
 :)
declare function xqdoc-html:tags(
  $node as element()?)
  as element(tr)*
{
  for $key in $node/*
  let $name := local-name($key)
  where $name = $xqdoc-html:TAGS
  let $value := $key/node()
  where $value
  return <tr>
    <td><b>{ xqdoc-html:capitalize($name) }:</b></td>
    <td>{ $value }</td>
  </tr>
};

(:~
 : Capitalizes the specified string.
 : @param string  string to be capitalized
 : @return        resulting string
 :)
declare %private function xqdoc-html:capitalize($string) {
  upper-case(substring($string, 1, 1)) ||
  lower-case(substring($string, 2))
};
