(:~
 : This <a href="http://docs.basex.org/wiki/Module_Library">XQuery Module</a> contains functions related to file system operations, such as listing, reading, or writing files. This module is based on the <a href="http://expath.org/spec/file">EXPath File Module</a> .
 : 
 : @author BaseX Team
 : @see http://docs.basex.org/wiki/Module_Library
 :)
module namespace file = "http://expath.org/ns/file";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

(:~
 : Lists all files and directories found in the specified <code>$dir</code> . The returned paths are relative to the provided path.
 : The optional parameter <code>$recursive</code> specifies whether sub-directories will be traversed, too.
 : The optional parameter <code>$pattern</code> defines a file name pattern in the <a href="http://docs.basex.org/wiki/Commands#Glob_Syntax">Glob Syntax</a> . If present, only those files and directories are returned that correspond to the pattern. Several patterns can be separated with a comma ( <code>,</code> ).
 :
 : @error output:not-found the specified file does not exist.
 : @error output:no-dir the specified path does not point to a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:list($dir as xs:string) as xs:string* external;

(:~
 : Lists all files and directories found in the specified <code>$dir</code> . The returned paths are relative to the provided path.
 : The optional parameter <code>$recursive</code> specifies whether sub-directories will be traversed, too.
 : The optional parameter <code>$pattern</code> defines a file name pattern in the <a href="http://docs.basex.org/wiki/Commands#Glob_Syntax">Glob Syntax</a> . If present, only those files and directories are returned that correspond to the pattern. Several patterns can be separated with a comma ( <code>,</code> ).
 :
 : @error output:not-found the specified file does not exist.
 : @error output:no-dir the specified path does not point to a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:list($dir as xs:string, $recursive as xs:boolean) as xs:string* external;

(:~
 : Lists all files and directories found in the specified <code>$dir</code> . The returned paths are relative to the provided path.
 : The optional parameter <code>$recursive</code> specifies whether sub-directories will be traversed, too.
 : The optional parameter <code>$pattern</code> defines a file name pattern in the <a href="http://docs.basex.org/wiki/Commands#Glob_Syntax">Glob Syntax</a> . If present, only those files and directories are returned that correspond to the pattern. Several patterns can be separated with a comma ( <code>,</code> ).
 :
 : @error output:not-found the specified file does not exist.
 : @error output:no-dir the specified path does not point to a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:list($dir as xs:string, $recursive as xs:boolean, $pattern as xs:string) as xs:string* external;

(:~
 : Returns the full paths to all files and directories found in the specified <code>$dir</code> .
 : The inverse function is <a href="#file:parent">file:parent</a> . The related function <a href="#file:list">file:list</a> returns relative file paths.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:no-dir the specified path does not point to a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:children($dir as xs:string) as xs:string* external;

(:~
 : Reads the binary content of the file specified by <code>$path</code> and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:base64Binary</code> .
 : The optional parameters <code>$offset</code> and <code>$length</code> can be used to read chunks of a file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:out-of-range the offset or length is negative, or the chosen values would exceed the file bounds.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:read-binary($path as xs:string) as xs:base64Binary external;

(:~
 : Reads the binary content of the file specified by <code>$path</code> and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:base64Binary</code> .
 : The optional parameters <code>$offset</code> and <code>$length</code> can be used to read chunks of a file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:out-of-range the offset or length is negative, or the chosen values would exceed the file bounds.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:read-binary($path as xs:string, $offset as xs:integer) as xs:base64Binary external;

(:~
 : Reads the binary content of the file specified by <code>$path</code> and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:base64Binary</code> .
 : The optional parameters <code>$offset</code> and <code>$length</code> can be used to read chunks of a file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:out-of-range the offset or length is negative, or the chosen values would exceed the file bounds.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:read-binary($path as xs:string, $offset as xs:integer, $length as xs:integer) as xs:base64Binary external;

(:~
 : Reads the textual contents of the file specified by <code>$path</code> and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:string</code> .
 : The optional parameter <code>$encoding</code> defines the encoding of the file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason. Invalid XML characters will be ignored if the <code> <a href="http://docs.basex.org/wiki/Options#CHECKSTRINGS">CHECKSTRINGS</a> </code> option is turned off.
 :)
declare function file:read-text($path as xs:string) as xs:string external;

(:~
 : Reads the textual contents of the file specified by <code>$path</code> and returns it as <a href="http://docs.basex.org/wiki/Streaming_Module">streamable</a>  <code>xs:string</code> .
 : The optional parameter <code>$encoding</code> defines the encoding of the file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason. Invalid XML characters will be ignored if the <code> <a href="http://docs.basex.org/wiki/Options#CHECKSTRINGS">CHECKSTRINGS</a> </code> option is turned off.
 :)
declare function file:read-text($path as xs:string, $encoding as xs:string) as xs:string external;

(:~
 : Reads the textual contents of the file specified by <code>$path</code> and returns it as a sequence of <code>xs:string</code> items.
 : The optional parameter <code>$encoding</code> defines the encoding of the file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:read-text-lines($path as xs:string) as xs:string external;

(:~
 : Reads the textual contents of the file specified by <code>$path</code> and returns it as a sequence of <code>xs:string</code> items.
 : The optional parameter <code>$encoding</code> defines the encoding of the file.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:read-text-lines($path as xs:string, $encoding as xs:string) as xs:string* external;

(:~
 : Creates the directory specified by <code>$dir</code> , including all non-existing parent directories.
 :
 : @error output:exists a file with the same path already exists.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:create-dir($dir as xs:string) as empty-sequence() external;

(:~
 : Creates a new temporary directory that did not exist before this function was called, and returns its full file path. The directory name begins and ends with the specified <code>$prefix</code> and <code>$suffix</code> . If no directory is specified via <code>$dir</code> , the directory will be placed in the system’s default temporary directory. The operation will create all non-existing parent directories.
 :
 : @error output:no-dir the specified directory points to a file.
 : @error output:io-error the directory could not be created.
 :)
declare function file:create-temp-dir($prefix as xs:string, $suffix as xs:string) as xs:string external;

(:~
 : Creates a new temporary directory that did not exist before this function was called, and returns its full file path. The directory name begins and ends with the specified <code>$prefix</code> and <code>$suffix</code> . If no directory is specified via <code>$dir</code> , the directory will be placed in the system’s default temporary directory. The operation will create all non-existing parent directories.
 :
 : @error output:no-dir the specified directory points to a file.
 : @error output:io-error the directory could not be created.
 :)
declare function file:create-temp-dir($prefix as xs:string, $suffix as xs:string, $dir as xs:string) as xs:string external;

(:~
 : Creates a new temporary file that did not exist before this function was called, and returns its full file path. The file name begins and ends with the specified <code>$prefix</code> and <code>$suffix</code> . If no directory is specified via <code>$dir</code> , the file will be placed in the system’s default temporary directory. The operation will create all non-existing parent directories.
 :
 : @error output:no-dir the specified directory points to a file.
 : @error output:io-error the directory could not be created.
 :)
declare function file:create-temp-file($prefix as xs:string, $suffix as xs:string) as xs:string external;

(:~
 : Creates a new temporary file that did not exist before this function was called, and returns its full file path. The file name begins and ends with the specified <code>$prefix</code> and <code>$suffix</code> . If no directory is specified via <code>$dir</code> , the file will be placed in the system’s default temporary directory. The operation will create all non-existing parent directories.
 :
 : @error output:no-dir the specified directory points to a file.
 : @error output:io-error the directory could not be created.
 :)
declare function file:create-temp-file($prefix as xs:string, $suffix as xs:string, $dir as xs:string) as xs:string external;

(:~
 : Recursively deletes a file or directory specified by <code>$path</code> .
 : The optional parameter <code>$recursive</code> specifies whether sub-directories will be deleted, too.
 :
 : @error output:not-found the specified path does not exist.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:delete($path as xs:string) as empty-sequence() external;

(:~
 : Recursively deletes a file or directory specified by <code>$path</code> .
 : The optional parameter <code>$recursive</code> specifies whether sub-directories will be deleted, too.
 :
 : @error output:not-found the specified path does not exist.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:delete($path as xs:string, $recursive as xs:boolean) as empty-sequence() external;

(:~
 : Writes a serialized sequence of items to the specified file. If the file already exists, it will be overwritten.
 : The <code>$params</code> argument contains serialization parameters (see <a href="http://docs.basex.org/wiki/Serialization">Serialization</a> for more details), which can either be specified
 : <ul> <li> as children of an <code>&lt;output:serialization-parameters/&gt;</code> element, as defined for the <a href="http://www.w3.org/TR/xpath-functions-30/#func-serialize">fn:serialize()</a> function; e.g.: </li> </ul>  <pre class="brush:xml"> &lt;output:serialization-parameters&gt; &lt;output:method value='xml'/&gt; &lt;output:cdata-section-elements value="div"/&gt; ... &lt;/output:serialization-parameters&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "method": "xml", "cdata-section-elements": "div", ... } </pre> 
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write($path as xs:string, $items as item()*) as empty-sequence() external;

(:~
 : Writes a serialized sequence of items to the specified file. If the file already exists, it will be overwritten.
 : The <code>$params</code> argument contains serialization parameters (see <a href="http://docs.basex.org/wiki/Serialization">Serialization</a> for more details), which can either be specified
 : <ul> <li> as children of an <code>&lt;output:serialization-parameters/&gt;</code> element, as defined for the <a href="http://www.w3.org/TR/xpath-functions-30/#func-serialize">fn:serialize()</a> function; e.g.: </li> </ul>  <pre class="brush:xml"> &lt;output:serialization-parameters&gt; &lt;output:method value='xml'/&gt; &lt;output:cdata-section-elements value="div"/&gt; ... &lt;/output:serialization-parameters&gt; </pre>  <ul> <li> as map, which contains all key/value pairs: </li> </ul>  <pre class="brush:xml"> map { "method": "xml", "cdata-section-elements": "div", ... } </pre> 
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write($path as xs:string, $items as item()*, $params as item()) as empty-sequence() external;

(:~
 : Writes a binary item (xs:base64Binary, xs:hexBinary) to the specified file. If the file already exists, it will be overwritten.
 : If <code>$offset</code> is specified, data will be written at this file position. An existing file may be resized by that operation.
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:out-of-range the offset is negative, or it exceeds the current file size.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write-binary($path as xs:string, $value as xs:anyAtomicType) as empty-sequence() external;

(:~
 : Writes a binary item (xs:base64Binary, xs:hexBinary) to the specified file. If the file already exists, it will be overwritten.
 : If <code>$offset</code> is specified, data will be written at this file position. An existing file may be resized by that operation.
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:out-of-range the offset is negative, or it exceeds the current file size.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write-binary($path as xs:string, $value as xs:anyAtomicType, $offset as xs:integer) as empty-sequence() external;

(:~
 : Writes a string to the specified file. If the file already exists, it will be overwritten.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write-text($path as xs:string, $value as xs:string) as empty-sequence() external;

(:~
 : Writes a string to the specified file. If the file already exists, it will be overwritten.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write-text($path as xs:string, $value as xs:string, $encoding as xs:string) as empty-sequence() external;

(:~
 : Writes a sequence of strings to the specified file, each followed by the system specific newline character. If the file already exists, it will be overwritten.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write-text-lines($path as xs:string, $values as xs:string*) as empty-sequence() external;

(:~
 : Writes a sequence of strings to the specified file, each followed by the system specific newline character. If the file already exists, it will be overwritten.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:write-text-lines($path as xs:string, $values as xs:string*, $encoding as xs:string) as empty-sequence() external;

(:~
 : Appends a serialized sequence of items to the specified file. If the file does not exists, a new file is created.
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append($path as xs:string, $items as item()*) as empty-sequence() external;

(:~
 : Appends a serialized sequence of items to the specified file. If the file does not exists, a new file is created.
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append($path as xs:string, $items as item()*, $params as item()) as empty-sequence() external;

(:~
 : Appends a binary item (xs:base64Binary, xs:hexBinary) to the specified file. If the file does not exists, a new one is created.
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append-binary($path as xs:string, $value as xs:anyAtomicType) as empty-sequence() external;

(:~
 : Appends a string to a file specified by <code>$path</code> . If the specified file does not exists, a new file is created.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append-text($path as xs:string, $value as xs:string) as empty-sequence() external;

(:~
 : Appends a string to a file specified by <code>$path</code> . If the specified file does not exists, a new file is created.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append-text($path as xs:string, $value as xs:string, $encoding as xs:string) as empty-sequence() external;

(:~
 : Appends a sequence of strings to the specified file, each followed by the system specific newline character. If the specified file does not exists, a new file is created.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append-text-lines($path as xs:string, $values as xs:string*) as empty-sequence() external;

(:~
 : Appends a sequence of strings to the specified file, each followed by the system specific newline character. If the specified file does not exists, a new file is created.
 : The optional parameter <code>$encoding</code> defines the output encoding (default: UTF-8).
 :
 : @error output:no-dir the parent of specified path is no directory.
 : @error output:is-dir the specified path is a directory.
 : @error output:unknown-encoding the specified encoding is not supported, or unknown.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:append-text-lines($path as xs:string, $values as xs:string*, $encoding as xs:string) as empty-sequence() external;

(:~
 : Copies a file or directory specified by <code>$source</code> to the file or directory specified by <code>$target</code> . If the target file already exists, it will be overwritten. No operation will be performed if the source and target path are equal.
 :
 : @error output:not-found the specified source does not exist.
 : @error output:exists the specified source is a directory and the target is a file.
 : @error output:no-dir the parent of the specified target is no directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:copy($source as xs:string, $target as xs:string) as empty-sequence() external;

(:~
 : Moves or renames the file or directory specified by <code>$source</code> to the path specified by <code>$target</code> . If the target file already exists, it will be overwritten. No operation will be performed if the source and target path are equal.
 :
 : @error output:not-found the specified source does not exist.
 : @error output:exists the specified source is a directory and the target is a file.
 : @error output:no-dir the parent of the specified target is no directory.
 : @error output:io-error the operation fails for some other reason.
 :)
declare function file:move($source as xs:string, $target as xs:string) as empty-sequence() external;

(:~
 : Returns an <code>xs:boolean</code> indicating whether a file or directory specified by <code>$path</code> exists in the file system.
 :)
declare function file:exists($path as xs:string) as xs:boolean external;

(:~
 : Returns an <code>xs:boolean</code> indicating whether the argument <code>$path</code> points to an existing directory.
 :)
declare function file:is-dir($path as xs:string) as xs:boolean external;

(:~
 : Returns an <code>xs:boolean</code> indicating whether the argument <code>$path</code> points to an existing file.
 :)
declare function file:is-file($path as xs:string) as xs:boolean external;

(:~
 : Retrieves the timestamp of the last modification of the file or directory specified by <code>$path</code> .
 :
 : @error output:not-found the specified path does not exist.
 :)
declare function file:last-modified($path as xs:string) as xs:dateTime external;

(:~
 : Returns the size, in bytes, of the file specified by <code>$path</code> , or <code>0</code> for directories.
 :
 : @error output:not-found the specified file does not exist.
 :)
declare function file:size($file as xs:string) as xs:integer external;

(:~
 : Returns the name of a file or directory specified by <code>$path</code> . An empty string is returned if the path points to the root directory.
 :)
declare function file:name($path as xs:string) as xs:string external;

(:~
 : Returns the absolute path to the parent directory of a file or directory specified by <code>$path</code> . An empty sequence is returned if the path points to a root directory.
 : The inverse function is <a href="#file:children">file:children</a> .
 :)
declare function file:parent($path as xs:string) as xs:string? external;

(:~
 : Transforms the <code>$path</code> argument to its native representation on the operating system.
 :
 : @error output:not-found the specified file does not exist.
 : @error output:io-error the specified path cannot be transformed to its native representation.
 :)
declare function file:path-to-native($path as xs:string) as xs:string external;

(:~
 : Transforms the <code>$path</code> argument to an absolute operating system path.
 :)
declare function file:resolve-path($path as xs:string) as xs:string external;

(:~
 : Transforms the path specified by <code>$path</code> into a URI with the <code>file://</code> scheme.
 :)
declare function file:path-to-uri($path as xs:string) as xs:string external;

(:~
 : Returns the directory separator used by the operating system, such as <code>/</code> or <code>\</code> .
 :)
declare function file:dir-separator() as xs:string external;

(:~
 : Returns the path separator used by the operating system, such as <code>;</code> or <code>:</code> .
 :)
declare function file:path-separator() as xs:string external;

(:~
 : Returns the line separator used by the operating system, such as <code>&amp;#10;</code> , <code>&amp;#13;&amp;#10;</code> or <code>&amp;#13;</code> .
 :)
declare function file:line-separator() as xs:string external;

(:~
 : Returns the system’s default temporary-file directory.
 :)
declare function file:temp-dir() as xs:string external;

(:~
 : Returns the current working directory. - This function returns the same result as the function call <code>file:resolve-path(<i>)</i> </code> <i>
 : </i> 
 :)
declare function file:current-dir() as xs:string external;

(:~
 : Returns the parent directory of the static base URI. If the Base URI property is undefined, the empty sequence is returned. - If a static base URI exists, and if points to a local file path, this function returns the same result as the expression <code>file:parent(static-base-uri())</code> .
 :)
declare function file:base-dir() as xs:string? external;



