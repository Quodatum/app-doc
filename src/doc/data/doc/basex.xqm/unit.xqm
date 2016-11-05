(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains annotations and functions for performing XQUnit tests.
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace unit = "x-http://basex.org/modules/unit";

(:~
 : Asserts that the effective boolean value of the specified <code>$test</code> is true and returns an empty sequence. Otherwise, raises an error. The <i>effective boolean value</i> of an expression can be explicitly computed by using the <code>fn:boolean</code> function.
 : The default failure message can be overridden with the <code>$info</code> argument.
 :
 : @error :UNIT0001 the assertion failed, or an error was raised.
 :)
declare function unit:assert($test as item()*) as empty-sequence() external;

(:~
 : Asserts that the effective boolean value of the specified <code>$test</code> is true and returns an empty sequence. Otherwise, raises an error. The <i>effective boolean value</i> of an expression can be explicitly computed by using the <code>fn:boolean</code> function.
 : The default failure message can be overridden with the <code>$info</code> argument.
 :
 : @error :UNIT0001 the assertion failed, or an error was raised.
 :)
declare function unit:assert($test as item()*, $info as item()) as empty-sequence() external;

(:~
 : Asserts that the specified arguments are equal according to the rules of the <code>fn:deep-equals</code> function. Otherwise, raises an error.
 : The default failure message can be overridden with the <code>$info</code> argument.
 :
 : @error :UNIT0001 the assertion failed, or an error was raised.
 :)
declare function unit:assert-equals($returned as item()*, $expected as item()*) as empty-sequence() external;

(:~
 : Asserts that the specified arguments are equal according to the rules of the <code>fn:deep-equals</code> function. Otherwise, raises an error.
 : The default failure message can be overridden with the <code>$info</code> argument.
 :
 : @error :UNIT0001 the assertion failed, or an error was raised.
 :)
declare function unit:assert-equals($returned as item()*, $expected as item()*, $info as item()) as empty-sequence() external;

(:~
 : Raises a unit error. The default failure message can be overridden with the <code>$info</code> argument.
 :
 : @error :UNIT0001 default error raised by this function.
 :)
declare function unit:fail() as empty-sequence() external;

(:~
 : Raises a unit error. The default failure message can be overridden with the <code>$info</code> argument.
 :
 : @error :UNIT0001 default error raised by this function.
 :)
declare function unit:fail($info as item()) as empty-sequence() external;



