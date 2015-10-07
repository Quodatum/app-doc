(:~
 : cxan info
 :)
declare namespace task="https://github.com/Quodatum/app-doc/task";
(: info about a cxan repository :)
declare namespace xweb="http://expath.org/ns/webapp";
declare variable $cxan:="http://cxan.org/";

(: @see http://cxan.org/faq#rest :)
declare function xweb:get($path){ 
 let $req:=<http:request method='get'><http:header name="Accept" value="application/xml"/></http:request>
 return http:send-request($req,resolve-uri($path,$cxan))[2] 
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
 :)
declare function xweb:package($pkg as xs:string) 
{ 
  xweb:get(concat("pkg/",$pkg))
};

let $pkgs:=xweb:repos() !xweb:packages(id) 
return $pkgs[1]! xweb:package(id)