(:~ 
 :excute xquery code from string
 :@author Andy Bunce
 :@version 0.1
 :)
module namespace eval = 'quodatum.eval';
declare default function namespace 'quodatum.eval'; 
declare function eval($xq as xs:string,$timeout as xs:double)
as item()*{
 let $bindings:=map{}
 let $opts:=map {
     "permission" := "create",
     "timeout":=$timeout
  }
  return try{
       let $t1:=prof:current-ms()
       let $x:= xquery:eval($xq,$bindings,$opts)
       let $t:=(prof:current-ms()-$t1) div 1000
       return ($t,$x)
      }catch * 
      {
        ($timeout ,$err:code)
      }
};