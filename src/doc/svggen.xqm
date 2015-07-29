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

(:~
 : svg graph for components referenced in package
 :)
declare function components($pkg as element())
{
   <svg height="100" width="100">
  <circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill="green" />
  Sorry, your browser does not support inline SVG.  
</svg> 
};