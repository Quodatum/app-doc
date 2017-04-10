(:~
 : cxan info demo
 :)
 module namespace cxan = 'http://cxan.org/';
declare namespace task="https://github.com/Quodatum/app-doc/task";
(: info about a cxan repository :)
declare namespace xweb="http://expath.org/ns/webapp";
declare variable $cxan:REPOSITORY:="http://cxan.org/";

(: @see http://cxan.org/faq#rest :)
declare function cxan:get($path){ 
 let $req:=<http:request method='get'><http:header name="Accept" value="application/xml"/></http:request>
 return http:send-request($req,resolve-uri($path,$cxan:REPOSITORY))[2] 
};
(:~ 
 :repos
 :)
declare function cxan:repos() as element(repo)*
{ 
  cxan:get("pkg")/repositories/repo
};

(:~ 
 : packages in $repo
 :)
declare function cxan:packages($repo as xs:string) as element(pkg)*
{ 
  cxan:get(concat("pkg/",$repo))/packages/pkg 
};

(:~ 
 : package detail
 : @param $pkg e.g "joewiz/xqjson"
 :)
declare function cxan:package($pkg as xs:string) as element(pkg) 
{ 
  cxan:get(concat("pkg/",$pkg))/pkg
};

(:~ 
 : @return package uri that can be used to retrieve xar
 : @param $pkg e.g "joewiz/xqjson"
 :)
declare function cxan:version($pkg as xs:string,$version) as xs:anyURI
{ 
  let $p:=cxan:package($pkg)
  let $v:=$p/version[@num=$version]/file[@role="pkg"]
  return if(starts-with( resolve-uri($v/@name),"file:/"))
         then   concat($cxan:REPOSITORY, "file/" , $pkg, "/" , $v/@name)  
         else $v  
};

