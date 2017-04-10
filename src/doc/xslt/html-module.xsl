<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:doc="http://www.xqdoc.org/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
	exclude-result-prefixes="xs doc fn" version="2.0">
	<!-- Standalone xqdoc:xqdoc transform -->
	<xsl:param name="source" as="xs:string" />
	<xsl:variable name="css"
		select="'../resources/base.css'" />
	<xsl:variable name="vars" select="//doc:variable" />
	<xsl:variable name="funs" select="//doc:function" />
	<!-- generate module html // -->
	<xsl:template match="//doc:xqdoc">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta http-equiv="Generator"
					content="xquerydoc - https://github.com/xquery/xquerydoc" />

				<title>
					<xsl:value-of select="doc:module/doc:uri" />
					- xqDoc
				</title>
				<style type="text/css">
					body {
					font-family: Helvetica;
					padding: 0.5em 1em;
					}
					pre {
					font-family: Inconsolata, Consolas, monospace;
					}
					ol.results {
					padding-left: 0;
					}
					.footer {
					text-align:right;
					border-top: solid 4px;
					padding: 0.25em 0.5em;
					font-size: 85%;
					color: #999;
					}
					li.result {
					list-style-position: inside;
					list-style: none;
					height:140px;
					}
					h2 {
					display: inline-block;
					margin: 0;
					}

					h2 a,
					.result h3 a {
					text-decoration: inherit;
					color: inherit;
					}
					h3{
					font-size: 140%;
					background-color: #aaa;
					border-bottom: 1px solid #000;
					width: 100%;
					}
					h4{
					font-size: 100%;
					background-color: #ddd;
					width: 90%;
					}

					.namespace {
					color: #999;
					}
					.namespace:before {
					content: "{";
					}
					.namespace:after {
					content: "}";
					}
					table{
					width:75%;
					float:right;
					}
					td {
					height:100px;
					width:50%;
					vertical-align:text-top;
					}
				</style>
				<style type="text/css">
					/* from xsl:query.xsl (D) from
					https://www.w3.org/TR/xpath-functions-31*/
					div.exampleInner pre {
					margin-left: 1em;
					margin-top: 0em; margin-bottom: 0em}

					pre.small {
					font-size: small }
					div.exampleOuter {border: 4px double gray;
					margin: 0em; padding: 0em}
					div.exampleInner { background-color:
					#d5dee3;
					padding: 4px; margin: 0em }

					div.exampleInner table { border:
					0;
					border-spacing: 0;
					}

					div.exampleInner td { vertical-align:
					baseline;
					padding: 0;
					}

					div.exampleWrapper { margin: 4px }
					div.exampleHeader { font-weight: bold;
					margin: 4px}

					div.proto {
					border: 0;
					border-spacing: 0;
					}

					div.issue { border-bottom-color:
					black;
					border-bottom-style: solid;
					border-bottom-width: 1pt;
					margin-bottom: 20pt;
					}

					th.issue-toc-head { border-bottom-color:
					black;
					border-bottom-style: solid;
					border-bottom-width: 1pt;
					}


					div.schemaComp { border: 4px double gray;
					margin: 0em 1em;
					padding:
					0em;
					}
					div.compHeader { margin: 4px;
					font-weight: bold;
					}
					span.schemaComp { background-color: white;
					color: #A52A2A;
					}
					div.compBody { border-top-width: 4px;
					border-top-style: double;
					border-top-color: #d3d3d3;
					padding: 4px;
					margin: 0em;
					}

					div.exampleInner { background-color: #d5dee3;
					color: black;
					border-top-width: 4px;
					border-top-style: double;
					border-top-color:
					#d3d3d3;
					border-bottom-width: 4px;
					border-bottom-style: double;
					border-bottom-color: #d3d3d3;
					padding: 4px;
					margin-bottom: 4px;
					}

					div.issueBody { margin-left: 0.25in;
					}

					code.function { font-weight:
					bold;
					}
					code.return-type { font-style: italic;
					}
					code.return-varies {
					font-weight: bold;
					font-style: italic;
					}
					code.type { font-style:
					italic;
					}
					code.as { font-style: normal;
					}
					code.arg {
					}
					code.strikeout {
					text-decoration: line-through;
					}
					code.small { font-size: small;
					}
					p.table.footnote { font-size: 8pt;
					}

					table.casting { font-size:
					x-small;
					}
					table.hierarchy { font-size: x-small;
					}
					table.proto {

					}

					td.castY { background-color: #7FFF7F;
					color: black;
					text-align:
					center;
					vertical-align: middle;
					}

					td.castN { background-color:
					#FF7F7F;
					color: black;
					text-align: center;
					vertical-align: middle;
					}

					td.castM { background-color: white;
					color: black;
					text-align: center;
					vertical-align: middle;
					}

					td.castOther { background-color: yellow;
					color: black;
					text-align: center;
					vertical-align: middle;
					}

					span.cancast:hover { background-color: #ffa;
					color: black;
					}

					div.protoref { margin-left: 0.5in;
					text-indent: -0.5in;
					}

					dd.indent {
					margin-left: 2em;
					}

					p.element-syntax { border: solid thin;
					background-color: #ffccff
					}

					p.element-syntax-chg { border: solid
					thick yellow; background-color: #ffccff
					}

					div.proto {
					padding: .5em;
					border: .5em;
					border-left-style: solid;
					page-break-inside: avoid;
					margin: 1em auto;
					border-color: #ff99ff;
					background: #ffe6ff;
					overflow: auto;
					}


					div.example-chg { border: solid thick yellow;
					background-color: #40e0d0; padding:
					1em
					}

					div.ffheader {
					margin-top:
					.8rem;
					font-size: 140%;
					font-variant: all-small-caps;
					text-transform:
					lowercase;
					font-weight: bold;
					color: hsla(203, 20%, 40%, .7);
					}

					span.verb { font: small-caps 100% sans-serif
					}

					span.error {
					font-size: small
					}

					span.definition { font: small-caps 100% sans-serif
					}

					span.grayed { color: gray
					}

					table.scrap td {
					vertical-align:
					baseline;
					text-align: left;
					padding-left: 30px;
					}

					table.data
					table.index {
					border-bottom:2px !important ;
					}
				</style>
				<script src="lib/prettify.js" type="text/javascript">&#160;</script>
				<script src="lib/lang-xq.js" type="text/javascript">&#160;</script>
				<link rel="stylesheet" type="text/css" href="{$css}" />
				<link rel="stylesheet" type="text/css" href="lib/prettify.css" />
			</head>
			<body class="home">
				<div id="main">
					<xsl:apply-templates />

					<div>
						<h3>Original Source Code</h3>
						<pre class="prettyprint lang-xq">
							<xsl:value-of select="$source" />
						</pre>
					</div>
					<br />

					<div class="footer">
						<p style="text-align:right">
							<i>
								<xsl:value-of select="()" />
							</i>
							|
							generated by ?
						</p>
					</div>
				</div>
				<xsl:call-template name="toc" />
				<script type="application/javascript">
					window.onload = function(){ prettyPrint(); }
				</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="doc:module">
		<h1>
			<span class="namespace">
				<xsl:value-of select="doc:uri" />
			</span>
			&#160;
			<xsl:value-of select="@type" />
			module
		</h1>
		<xsl:apply-templates select="*[not(name(.) eq 'doc:uri')]" />
	</xsl:template>

	<xsl:template match="doc:variables">
		<div id="variables">
			<h3>
				<a href="#variables">Variables</a>
			</h3>
			<xsl:apply-templates />
		</div>
	</xsl:template>

	<xsl:template match="doc:variable[@private]" />

	<xsl:template match="doc:variable">
		<xsl:variable name="id" select="concat('$',doc:name)" />
		<div id="{ $id }">
			<h4>
				<a href="#{$id}">
					<xsl:value-of select="$id" />
				</a>
			</h4>
			<pre>
				as
				<xsl:value-of select="doc:type" />
				<xsl:value-of select="doc:type/@occurrence" />
			</pre>
			<xsl:apply-templates select="doc:comment" />
		</div>
	</xsl:template>

	<xsl:template match="doc:uri">
		<xsl:value-of select="." />
	</xsl:template>

	<xsl:template match="doc:functions">
		<div id="functions">
			<h3>
				<a href="#functions">Functions</a>
			</h3>
			<xsl:apply-templates />
		</div>
	</xsl:template>

	<xsl:template match="doc:function[@private]" />

	<xsl:template match="doc:function">
		<xsl:variable name="id" select="concat( doc:name, '#', @arity)" />
		<div id="{ $id }">
			<h4>
				<a href="#{$id}">
					<xsl:value-of select="$id" />
				</a>
			</h4>
			<div class="proto">
				<xsl:value-of select="doc:signature" />
			</div>
			<xsl:apply-templates select="* except (doc:name|doc:signature)" />
			<xsl:apply-templates select="doc:comment/doc:error" />
		</div>
	</xsl:template>

	<xsl:template match="doc:parameters">
		<h5>Params</h5>
		<ul>
			<xsl:apply-templates />
		</ul>
	</xsl:template>

	<xsl:template match="doc:parameter">
		<li>
			<xsl:value-of select="doc:name" />
			as
			<xsl:value-of select="doc:type" />
			<xsl:value-of select="doc:type/@occurrence" />
			<xsl:variable name="name" select="string(doc:name)" />
			<xsl:for-each
				select="../../doc:comment/doc:param[starts-with(normalize-space(.), $name) or starts-with(normalize-space(.), concat('$',$name))]">
				<xsl:value-of select="substring-after(normalize-space(.), $name)" />
			</xsl:for-each>
		</li>
	</xsl:template>

	<xsl:template match="doc:return">
		<h5>Returns</h5>
		<ul>
			<li>
				<xsl:value-of select="doc:type" />
				<xsl:value-of select="doc:type/@occurrence" />
				<xsl:for-each select="../doc:comment/doc:return">
					<xsl:text>: </xsl:text>
					<xsl:value-of select="normalize-space(.)" />
				</xsl:for-each>
			</li>
		</ul>
	</xsl:template>

	<xsl:template match="doc:error" mode="custom" />

	<xsl:template match="doc:error">
		<h5>Errors</h5>
		<p>
			<xsl:apply-templates mode="custom" />
		</p>
	</xsl:template>

	<xsl:template match="doc:comment">
		<xsl:apply-templates mode="custom" />
	</xsl:template>

	<xsl:template match="doc:description" mode="custom">
		<p>
			<xsl:apply-templates mode="custom" />
		</p>
	</xsl:template>

	<xsl:template match="*:h1" mode="custom">
		<h1>
			<xsl:apply-templates mode="custom" />
		</h1>
	</xsl:template>

	<xsl:template match="*:ul" mode="custom">
		<ul>
			<xsl:apply-templates mode="custom" />
		</ul>
	</xsl:template>

	<xsl:template match="*:li" mode="custom">
		<li>
			<xsl:apply-templates mode="custom" />
		</li>
	</xsl:template>

	<xsl:template match="*:p" mode="custom">
		<p>
			<xsl:apply-templates mode="custom" />
		</p>
	</xsl:template>

	<xsl:template match="*:pre" mode="custom">
		<pre class="prettyprint lang-xq">
			<xsl:value-of select="." />
		</pre>
	</xsl:template>

	<xsl:template match="doc:author" mode="custom #default">
		<p>
			Author:
			<xsl:value-of select="." />
		</p>
	</xsl:template>

	<xsl:template match="doc:version" mode="custom #default">
		<p>
			Version:
			<xsl:value-of select="." />
		</p>
	</xsl:template>

	<xsl:template match="doc:see" mode="custom">
		See also:
		<xsl:for-each select="tokenize(.,'[ \t\r\n,]+')[. ne '']">
			<xsl:if test="position() ne 1">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="contains(.,'#')">
					<a
						href="#{ concat('func_', replace(substring-before(.,'#'), ':', '_'),
            '_', substring-after(.,'#')) }">
						<xsl:value-of select="." />
					</a>
				</xsl:when>
				<xsl:when test="starts-with(.,'$')">
					<a href="#{ concat('var_', replace(substring-after(.,'$'), ':', '_')) }">
						<xsl:value-of select="." />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="doc:param" mode="custom" />
	<xsl:template match="doc:return" mode="custom" />

	<!--xsl:template match="doc:custom" mode="custom"> <xsl:apply-templates 
		select="."/> </xsl:template> <xsl:template match="doc:param" mode="custom"> 
		<xsl:apply-templates select="."/> </xsl:template> <xsl:template match="doc:version" 
		mode="custom"> <xsl:apply-templates select="."/> </xsl:template -->

	<xsl:template match="doc:control" />

	<xsl:template match="text()" mode="custom #default">
		<xsl:value-of select="normalize-space(.)" />
	</xsl:template>

	<xsl:template name="toc">
		<nav id="toc">
			<h2>
				<a id="contents"></a>
				Table of Contents <a href="..">(up)</a>
			</h2>
			<ol class="toc">
				<li>
					<a href="#main">
						<span class="secno">1 </span>
						<span class="content">Introduction</span>
					</a>
                </li>
                <li>
					<ol class="toc">
						<li>
							<a href="#variables">
								<span class="secno">2 </span>
								<span class="content">Variables</span>
							</a>
							<ol class="toc">
								<xsl:for-each select="$vars">
								  <xsl:sort select="doc:name"/>
								    <xsl:variable name="id" select="concat('$',doc:name)" />
									<li>
										<a href="#{$id}">
											<span class="secno">2.<xsl:value-of select="position()"/></span>
											<span class="content">
												<xsl:value-of select="$id" />
											</span>
										</a>
									</li>
								</xsl:for-each>
							</ol>
						</li>
					</ol>
                    </li>
                    <li>
					<ol class="toc">
						<li>
							<a href="#functions">
								<span class="secno">3 </span>
								<span class="content">Functions</span>
							</a>
							<ol class="toc">
                                <xsl:for-each select="$funs">
                                <xsl:sort select="doc:name"/>
                                <xsl:variable name="id" select="concat( doc:name, '#', @arity)" />
                                    <li>
                                        <a href="#{$id}">
                                            <span class="secno">3.<xsl:value-of select="position()"/></span>
                                            <span class="content">
                                                <xsl:value-of select="$id" />
                                            </span>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ol>
						</li>
					</ol>
					
				</li>
			</ol>
		</nav>
	</xsl:template>
</xsl:stylesheet>
