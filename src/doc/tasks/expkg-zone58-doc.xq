(:~
 : transform xml with xslt generate html for xqdoc for \expkg-zone58.github.io
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";

declare variable $projects-url:="C:\Users\andy\git\expkg-zone58.github.io\projects.xml";
declare variable $projects:=doc($projects-url)/projects/project;
declare variable $destdir external :="C:\Users\andy\git\expkg-zone58.github.io\projects\";
declare variable $xslt external :="C:\Users\andy\git\expkg-zone58.github.io\xslt\html-module.xsl";

declare %updating function local:gen-project-doc($xqdoc,$dest){
    let $params:=map{"source":"Not available","cache":true() }
    let $h:=xslt:transform($xqdoc,$xslt,$params)
    return file:write($dest,$h,map{"method": "html","version":"5.0"})
};

(for $p in $projects
  let $src:=$p!file:resolve-path(./doc/@src,./local/@path)
  let $dest:=file:resolve-path($p/@name || ".html",$destdir)
  return local:gen-project-doc($src,$dest)
  )
  ,db:output("done")
