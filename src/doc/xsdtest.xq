import module namespace xsd="apb.schema.rest" at "schema.xqm";
declare namespace J= "org.apb.modules.Xsd";

let $xpl:="C:\Users\andy\workspace\xprocdoc\tests\x.xpl"
let $a1:=validate:xsd-info($xpl,$xsd:xproc)
let $a2:=xsd:xproc($xpl)
(:  let $a3:=xsd:xproc2($xpl)  :)
let $a4:=J:validate($xpl,$xsd:xproc)
return $a4
