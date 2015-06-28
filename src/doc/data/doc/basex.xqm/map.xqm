(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions for manipulating maps, which will officially be introduced with <a href="http://docs.basex.org/wiki/XQuery_3.1#Maps">XQuery 3.1</a> . <br/>  <b>Please note</b> that the functions are subject to change until the specification has reached its final stage.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace map = "http://www.w3.org/2005/xpath-functions/map";

(:~
 : Returns true if the <i>map</i> supplied as <code>$input</code> contains an entry with a key equal to the supplied value of <code>$key</code> ; otherwise it returns false. No error is raised if the map contains keys that are not comparable with the supplied <code>$key</code> . <p>If the supplied key is <code>xs:untypedAtomic</code>, it is compared as an instance of <code>xs:string</code>. If the supplied key is the <code>xs:float</code> or <code>xs:double</code> value <code>NaN</code>, the function returns true if there is an entry whose key is <code>NaN</code>, or false otherwise. </p> 
 :)
declare function map:contains($input as map(*), $key as xs:anyAtomicType) as xs:boolean external;

(:~
 : Creates a new <i>map</i> containing a single entry. The key of the entry in the new map is <code>$key</code> , and its associated value is <code>$value</code> . If the supplied key is <code>xs:untypedAtomic</code> , it is compared as an instance of <code>xs:string</code> . If the supplied key is the <code>xs:float</code> or <code>xs:double</code> value <code>NaN</code> , the function returns the value in the entry whose key is <code>NaN</code> , or the empty sequence otherwise. <p>The function <code>map:entry</code> is intended primarily for use in conjunction with the function <code> <a href="#map:merge">map:merge</a> </code>. For example, a map containing seven entries may be constructed like this: </p>  <pre class="brush:xquery"> map:merge(( map:entry("Su", "Sunday"), map:entry("Mo", "Monday"), map:entry("Tu", "Tuesday"), map:entry("We", "Wednesday"), map:entry("Th", "Thursday"), map:entry("Fr", "Friday"), map:entry("Sa", "Saturday") )) </pre>  <p>Unlike the <code>map { ... }</code> expression, this technique can be used to construct a map with a variable number of entries, for example: </p>  <pre class="brush:xquery">map:merge(for $b in //book return map:entry($b/isbn, $b))</pre> 
 :)
declare function map:entry($key as xs:anyAtomicType, $value as item()*) as map(*) external;

(:~
 : Applies a function to every entry of the map <code>$input</code> and returns the results as a sequence. The function supplied as <code>$fun</code> takes two arguments. It is called supplying the key of the map entry as the first argument, and the associated value as the second argument.
 :)
declare function map:for-each($input as map(*), $fun as function(xs:anyAtomicType, item()*) as item()) as item()* external;

(:~
 : Returns the value associated with a supplied key in a given map. This function attempts to find an entry within the <i>map</i> supplied as <code>$input</code> that has a key equal to the supplied value of <code>$key</code> . If there is such an entry, it returns the associated value; otherwise it returns an empty sequence. No error is raised if the map contains keys that are not comparable with the supplied <code>$key</code> . If the supplied key is <code>xs:untypedAtomic</code> , it is converted to <code>xs:string</code> . If the supplied key is the <code>xs:float</code> or <code>xs:double</code> value <code>NaN</code> , the function returns an empty sequence. <p>A return value of <code>()</code> from <code>map:get</code> could indicate that the key is present in the map with an associated value of <code>()</code>, or it could indicate that the key is not present in the map. The two cases can be distinguished by calling <code>map:contains</code>. Invoking the <i>map</i> as a function item has the same effect as calling <code>get</code>: that is, when <code>$input</code> is a map, the expression <code>$input($K)</code> is equivalent to <code>get($input, $K)</code>. Similarly, the expression <code>get(get(get($input, 'employee'), 'name'), 'first')</code> can be written as <code>$input('employee')('name')('first')</code>. </p> 
 :)
declare function map:get($input as map(*), $key as xs:anyAtomicType) as item()* external;

(:~
 : Returns a sequence containing all the key values present in a map. The function takes any <i>map</i> as its <code>$input</code> argument and returns the keys that are present in the map as a sequence of atomic values. The order may differ from the order in which entries were inserted in the map.
 :)
declare function map:keys($input as map(*)) as xs:anyAtomicType* external;

(:~
 : Constructs and returns a new map. The <i>map</i> is formed by combining the contents of the maps supplied in the <code>$input</code> argument. The maps are combined as follows: <ol> <li> There is one entry in the new map for each distinct key value present in the union of the input maps, where keys are considered distinct according to the rules of the <code>distinct-values</code> function. </li> <li> The associated value for each such key is taken from the last map in the input sequence <code>$input</code> that contains an entry with this key. </li> </ol>  <p>There is no requirement that the supplied input maps should have the same or compatible types. The type of a map (for example <code>map(xs:integer, xs:string)</code>) is descriptive of the entries it currently contains, but is not a constraint on how the map may be combined with other maps. </p> 
 :)
declare function map:merge($input as map(*)*) as map(*) external;

(:~
 : Creates a new <i>map</i> , containing the entries of the <code>$input</code> argument and a new entry composed by <code>$key</code> and <code>$value</code> . The semantics of this function are equivalent to <code>map:merge(($input, map { $key, $value }))</code> 
 :)
declare function map:put($input as map(*), $key as xs:anyAtomicType, $value as item()*) as map(*) external;

(:~
 : Constructs a new map by removing an entry from an existing map. The entries in the new map correspond to the entries of <code>$input</code> , excluding any entry whose key is equal to <code>$key</code> . <p>No failure occurs if the input map contains no entry with the supplied key; the input map is returned unchanged </p> 
 :)
declare function map:remove($input as map(*), $key as xs:anyAtomicType) as map(*) external;

(:~
 : Returns a the number of entries in the supplied map. The function takes any <i>map</i> as its <code>$input</code> argument and returns the number of entries that are present in the map.
 :)
declare function map:size($input as map(*)) as xs:integer external;

(:~
 : This function is specific to BaseX. It returns a string representation of the supplied map. The purpose of this function is to get an insight into the structure of a map item; it cannot necessarily be used for reconstructing the original map.
 :)
declare function map:serialize($input as map(*)) as xs:string external;



