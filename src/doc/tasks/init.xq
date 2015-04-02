let $id:=client:connect('localhost',1984, 'admin', 'admin') 
(:
let $_:=if(client:query($id,'db:exists("TESTXX")')) then () else client:execute($id, 'create database TESTXX') 
let $_:= client:execute($id, 'OPEN TESTXX') 
let $n:= client:query($id, 'collection("TESTXX")=>count()')
let $_:= if($n=0) then client:execute($id,'ADD TO embedded.xml <root>0</root>') else ()
:)
let $_:= client:execute($id, 'CHECK TESTXX') 
let $_:= client:query($id, 'replace value of node /root with 1+/root')
let $a:=for $i in 1 to 10000
 return client:query($id, 'replace value of node /root with 1+/root')
let $_:= client:query($id, '/root')
return $_