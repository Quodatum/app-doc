
declare variable $xml:="C:\Users\andy\git\graphxq\src\graphxq\data\samples\sample.graphml";
declare variable $xslt:="C:\Users\andy\git\graphxq\src\graphxq\data\samples\full.xsl";
declare variable $out:="C:\Users\andy\git\graphxq\src\graphxq\data\samples\out.svg";

xslt:transform($xml,$xslt)
=>put($out) 