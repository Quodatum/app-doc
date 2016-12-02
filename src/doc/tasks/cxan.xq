(:~
 : cxan info demo
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
(: info about a cxan repository :)
declare namespace xweb="http://expath.org/ns/webapp";
declare variable $REPOSITORY:="http://cxan.org/";

(: @see http://cxan.org/faq#rest :)
declare function xweb:get($path){ 
 let $req:=<http:request method='get'><http:header name="Accept" value="application/xml"/></http:request>
 return http:send-request($req,resolve-uri($path,$REPOSITORY))[2] 
};
(:~ 
 :repos
 :)
declare function xweb:repos() as element(repo)*
{ 
  xweb:get("pkg")/repositories/repo
};

(:~ 
 : packages in $repo
 :)
declare function xweb:packages($repo as xs:string) as element(pkg)*
{ 
  xweb:get(concat("pkg/",$repo))/packages/pkg 
};

(:~ 
 : package detail
 : @param $pkg e.g "joewiz/xqjson"
 :)
declare function xweb:package($pkg as xs:string) as element(pkg) 
{ 
  xweb:get(concat("pkg/",$pkg))/pkg
};

(:~ 
 : @return package uri that can be used to retrieve xar
 : @param $pkg e.g "joewiz/xqjson"
 :)
declare function xweb:version($pkg as xs:string,$version) as xs:anyURI
{ 
  let $p:=xweb:package($pkg)
  let $v:=$p/version[@num=$version]/file[@role="pkg"]
  return if(starts-with( resolve-uri($v/@name),"file:/"))
         then   concat($REPOSITORY, "file/" , $pkg, "/" , $v/@name)  
         else $v  
};

let $pkgs:=xweb:repos() !xweb:packages(id) 
return  db:output(xweb:version("joewiz/xqjson","0.1.6"))