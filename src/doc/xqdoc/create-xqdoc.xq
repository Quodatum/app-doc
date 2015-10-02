(:~
 : This module generates an HTML documentation from all project modules.
 : @author Christian Grün, BaseX Team, 2013
 :)
import module namespace _ = 'docs' at 'docs.xqm';

(:~ Script directory. :)
declare variable $SCRIPT external := file:parent(static-base-uri()) || '/';
(:~ Input directory. recursively scanned for xq and xqm :)
declare variable $IN external :=file:resolve-path( '../',static-base-uri());
(:~ Output directory. :)
declare variable $OUTPUT external :=file:resolve-path( '../../../doc/xqdoc/',static-base-uri())|| "/";
(:~ Name of the documentation. :)
declare variable $TITLE external := 'XQuery documentation ';
(:~ Also show private variables. :)
declare variable $PRIVATE external := false();

(:~
 : Creates a page header.
 : @param  $level  level depth of target file
 : @return header
 :)
declare function _:head($level as xs:integer) {
  <head>
    <title>{ $TITLE }</title>
    <link rel="stylesheet" type="text/css"
      href="{ string-join((1 to $level) ! '../') }style.css"/>
  </head>
};

(:~
 : Creates a page logo.
 : @param  $level  level depth of target file
 : @return div element
 :)
declare function _:logo($level as xs:integer) {
  <div class="right"><img width="104"
    src="{ string-join((1 to $level) ! '../')}basex.svg"/></div>
};

(:~
 : Creates html pages for the specified modules.
 :
 : @param  $modules  module paths and inspected modules
 : @return ()
 :)
declare function _:create-doc(
  $modules as map(*))
  as empty-sequence()
{
  for $path in map:keys($modules)
  let $level := count(tokenize($path, '/')) - 1 return
  let $html := 
    <html>
    { _:head($level) }
    <body>{
      _:logo($level),
      _:create($path, $modules($path), $PRIVATE)
    }</body>
    </html>
  let $name := replace($path, '\.xqm?', '')
  return (
    file:create-dir(file:parent($OUTPUT || $name)),
    _:write-html($OUTPUT || $name || '.html', $html)
  )
};

(:~
 : Stores the documentation framework files.
 : @param $modules  module paths and inspected modules
 : @return ()
 :)
declare function _:create-index($modules as map(*)) as empty-sequence() {
  let $html := <html>
    { _:head(0) }
    <frameset cols="320,*">
      <frame name="modules" src="modules.html"/>
      <frame name="text" src="text.html"/>
    </frameset>
  </html>
  return _:write-html($OUTPUT || '/index.html', $html),

  let $html := <html>
    { _:head(0) }
    <body>
      <h2><a href='text.html' target='text'>Index</a></h2>{
        for $path in map:keys($modules)
        order by $path
        let $name := replace($path, '\.xqm?', '')
        return <div><a target='text' href="{ $name }.html">{ $name }</a></div>
    }</body>
  </html>
  return _:write-html($OUTPUT || '/modules.html', $html),

  let $html := <html>
    { _:head(0) }
    <body>
      { _:logo(0) }
      <h1>{ $TITLE }</h1>
      <h2>Module List</h2>
      <table>{
        for $path in map:keys($modules)
        order by $path
        let $name := replace($path, '\.xqm?', '')
        return <tr><td>{
          <a target='text' href="{ $name }.html">{ $name }</a>
        }</td><td>{
          (: Choose first sentence of description. :)
          let $text := string-join(($modules($path)/description//text()), ' ')
          return replace(normalize-space($text), '\..*', '.')
        }</td></tr>
      }</table>
    </body>
  </html>
  return _:write-html($OUTPUT || '/text.html', $html),

  (: copy media files :)
  ('style.css', 'basex.svg') ! file:copy($SCRIPT || ., $OUTPUT || .)
};

(:~
 : Writes an HTML page to disk.
 : @param $modules  query modules
 :)
declare function _:write-html(
  $path  as xs:string,
  $html  as element(html))
  as empty-sequence()
{
  file:write($path, $html, map {
    'method' : 'xhtml',
    'omit-xml-declaration' : 'no',
    'doctype-public' : '-//W3C//DTD XHTML 1.0 Transitional//EN',
    'doctype-system' : 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'
  })
};

(: delete old files :)
if(file:exists($OUTPUT)) then file:delete($OUTPUT, true()) else (),
(: create new files :)
let $files := _:files($IN, true(), '*.xqm,*.xq') ! replace(., '\\', '/')
let $_:=fn:trace($files,"####")
let $modules := map:merge($files ! map { . : inspect:module($IN || .) })
return (
  _:create-doc($modules),
  _:create-index($modules)
)
