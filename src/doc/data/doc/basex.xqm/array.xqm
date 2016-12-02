(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions for manipulating arrays, which will officially be introduced with <a href="http://docs.basex.org/wiki/XQuery_3.1#Arrays">XQuery 3.1</a> . <br/>  <b>Please note</b> that the functions are subject to change until the specification has reached its final stage.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace array = "x-http://www.w3.org/2005/xpath-functions/array";

(:~
 : Returns the number of members in <code>$array</code> . Note that because an array is an item, the <code>fn:count</code> function when applied to an array always returns <code>1</code> .
 :)
declare function array:size($input as array(*)) as xs:integer external;

(:~
 : Returns the <code>$array</code> member at the specified <code>$position</code> .
 :
 : @error :FOAY0001 <code>$position</code> is not in the range <code>1</code> to <code>array:size($array)</code> inclusive.
 :)
declare function array:get($array as array(*), $position as xs:integer) as item()* external;

(:~
 : Returns a copy of <code>$array</code> with a new <code>$member</code> attached.
 :)
declare function array:append($array as array(*), $member as item()*) as array(*) external;

(:~
 : Constructs a new array with with <code>$length</code> members of <code>$array</code> beginning from the specified <code>$position</code> .
 : The two-argument version of the function returns the same result as the three-argument version when called with <code>$length</code> equal to the value of <code>array:size($array) - $position + 1</code> .
 :
 : @error :FOAY0001 <code>$position</code> is less than one, or if <code>$position + $length</code> is greater than <code>array:size($array) + 1</code> .
 : @error :FOAY0002 <code>$length</code> is less than zero.
 :)
declare function array:subarray($array as array(*), $position as xs:integer) as array(*) external;

(:~
 : Constructs a new array with with <code>$length</code> members of <code>$array</code> beginning from the specified <code>$position</code> .
 : The two-argument version of the function returns the same result as the three-argument version when called with <code>$length</code> equal to the value of <code>array:size($array) - $position + 1</code> .
 :
 : @error :FOAY0001 <code>$position</code> is less than one, or if <code>$position + $length</code> is greater than <code>array:size($array) + 1</code> .
 : @error :FOAY0002 <code>$length</code> is less than zero.
 :)
declare function array:subarray($array as array(*), $position as xs:integer, $length as xs:integer) as array(*) external;

(:~
 : Returns a copy of <code>$array</code> without the member at the specified <code>$position</code> .
 :
 : @error :FOAY0001 <code>$position</code> is not in the range <code>1</code> to <code>array:size($array)</code> inclusive.
 :)
declare function array:remove($array as array(*), $position as xs:integer) as array(*) external;

(:~
 : Returns a copy of <code>$array</code> with one new <code>$member</code> at the specified <code>$position</code> . Setting <code>$position</code> to the value <code>array:size($array) + 1</code> yields the same result as <code>array:append($array, $insert)</code> .
 :
 : @error :FOAY0001 <code>$position</code> is not in the range <code>1</code> to <code>array:size($array) + 1</code> inclusive.
 :)
declare function array:insert-before($array as array(*), $position as xs:integer, $member as item()*) as array(*) external;

(:~
 : Returns the first member of <code>$array</code> . This function is equivalent to the expression <code>$array(1)</code> .
 :
 : @error :FOAY0001 The array is empty.
 :)
declare function array:head($array as array(*)) as item()* external;

(:~
 : Returns a new array with all members except the first from <code>$array</code> . This function is equivalent to the expression <code>array:remove($array, 1)</code> .
 :
 : @error :FOAY0001 The array is empty.
 :)
declare function array:tail($array as array(*)) as array(*) external;

(:~
 : Returns a new array with all members of <code>$array</code> in reverse order.
 :)
declare function array:reverse($array as array(*)) as array(*) external;

(:~
 : Concatenates the contents of several <code>$arrays</code> into a single array.
 :)
declare function array:join($arrays as array(*)*) as array(*) external;

(:~
 : Recursively flattens all arrays that occur in the supplied <code>$items</code> .
 :)
declare function array:flatten($items as item()*) as item()* external;

(:~
 : Returns a new array, in which each member is computed by applying <code>$function</code> to the corresponding member of <code>$array</code> .
 :)
declare function array:for-each($array as array(*), $function as function(item()*) as item()*) as array(*) external;

(:~
 : Returns a new array with those members of <code>$array</code> for which <code>$function</code> returns <code>true</code> .
 :)
declare function array:filter($array as array(*), $function as function(item()*) as xs:boolean) as array(*) external;

(:~
 : Evaluates the supplied <code>$function</code> cumulatively on successive members of the supplied <code>$array</code> from left to right and using <code>$zero</code> as first argument.
 :)
declare function array:fold-left($array as array(*), $zero as item()*, $function as function(item()*, item()*) as item()*) as item()* external;

(:~
 : Evaluates the supplied <code>$function</code> cumulatively on successive members of the supplied <code>$array</code> from right to left and using <code>$zero</code> as first argument.
 :)
declare function array:fold-right($array as array(*), $zero as item()*, $function as function(item()*, item()*) as item()*) as item()* external;

(:~
 : Returns a new array obtained by evaluating the supplied <code>$function</code> for each pair of members at the same position in <code>$array1</code> and <code>$array2</code> .
 :)
declare function array:for-each-pair($array1 as array(*), $array2 as array(*), $function as function(item()*) as item()*) as array(*) external;

(:~
 : Returns a new array with sorted <code>$array</code> members. If a sort <code>$key</code> function is given, it will be applied on all array members. The items of the resulting values will be sorted using the semantics of the <code>lt</code> expression.
 :)
declare function array:sort($array as array(*)) as array(*) external;

(:~
 : Returns a new array with sorted <code>$array</code> members. If a sort <code>$key</code> function is given, it will be applied on all array members. The items of the resulting values will be sorted using the semantics of the <code>lt</code> expression.
 :)
declare function array:sort($array as array(*), $key as function(item()*) as xs:anyAtomicType*) as array(*) external;

(:~
 : This function is specific to BaseX. It returns a string representation of the supplied array. The purpose of this function is to get an insight into the structure of an array item; it cannot necessarily be used for reconstructing the original array.
 :)
declare function array:serialize($input as array(*)) as xs:string external;



