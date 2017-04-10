xquery version "3.0";
(:~
: manage documentation svg generation
:
: @copyright quodatum ltd
: @author andy bunce
: @since may 2014
: @licence apache 2
:)
 
module namespace svggen = 'quodatum.doc.svg';
declare default function namespace 'quodatum.doc.svg';
import module namespace dotml="http://www.martin-loetzsch.de/DOTML";
import module namespace ex-graphviz="expkg-zone58:image.graphviz";
declare namespace cmpx="urn:quodatum:qd-cmpx:component";
(:~ example dotml 
 :)
declare variable $svggen:simple:=
<graph  xmlns="http://www.martin-loetzsch.de/DOTML" rankdir="LR">    
    <node   id="a" label="node1" fontsize="9" fontname="Arial"/>
    <node   id="b" label="node2" fontsize="9" fontname="Arial"/>
    <node   id="c" label="node3" fontsize="9" fontname="Arial"/>
    <node   id="d" label="node4" fontsize="9" fontname="Arial"/>
    <edge   from="a" to="b" fontname="Arial" fontsize="9" label="edge1"/>
    <edge   from="a" to="c" fontname="Arial" fontsize="9" label="edge2"/>
    <edge   from="b" to="c" fontname="Arial" fontsize="9" label="edge3"/>
    <edge   from="b" to="d" fontname="Arial" fontsize="9" label="edge4"/>
    <edge   from="c" to="d" fontname="Arial" fontsize="9" label="edge5"/>
</graph>;

declare variable $svggen:cmps:=
<graph  xmlns="http://www.martin-loetzsch.de/DOTML" rankdir="LR">    
    <node   id="a" label="cmps" fontsize="9" fontname="Arial"/>
  </graph>;


declare function name($name as xs:string) as xs:string
{
fn:translate($name,"-.","__")
};

declare function dump($item){
 ($item,file:write("junk.txt",$item))
};
  
declare function generate($pkg as element())
as element()
{
let $dot:= 
 <dotml:graph  rankdir="LR" fontname="Arial" label="Components"> 
		{(for $c in $pkg/cmpx:cmp
		 let $id:=name($c/@name)
		 let $colours:=map{"browser":"yellow","expath":"red"}
		 let $type:=$c/cmpx:type/fn:string()
		 return <dotml:node id="{$id}" label="{$c/@name}" shape="box" style="filled" 
		 fillcolor="{$colours?($type)}"
		 URL="javascript:alert('{$c/@name}')" />,
		 for $d in $pkg/cmpx:cmp/cmpx:dependency
		 return <dotml:edge from="{name($d/../@name)}" to="{name($d/@name)}"/>  )
		     }
        </dotml:graph>
		
return $dot
!dotml:to-dot(.) 
!ex-graphviz:to-svg(.)/*
(: !ex-graphviz:autosize(.) :)
};


(:~
 : svg graph for components referenced in package
 :)
declare function components($pkg as element())
as element(svg)
{
   <svg height="100" width="100">
  <circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill="green" />
  Sorry, your browser does not support inline SVG.  
</svg> 
};