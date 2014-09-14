<?xml version="1.0" encoding="UTF-8"?>
<!-- basex xqdoc o/p to html with bootstrap -->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xqdoc="http://www.xqdoc.org/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
	exclude-result-prefixes="xs xqdoc fn" version="2.0">

    <xsl:param name="app" as="xs:string" />
	<xsl:param name="path" as="xs:string" />

	<!-- generate module html // -->
	<xsl:template match="//xqdoc:xqdoc">
		<div class="row">
			<div class="col-md-2">
				<xsl:call-template name="list">
					<xsl:with-param name="cmps"
						select="//xqdoc:variable|//xqdoc:function" />
				</xsl:call-template>
			</div>
			<div class="col-md-10" style="height:70vh;overflow:scroll;">
				<h2>

					<xsl:value-of select="xqdoc:module/xqdoc:name" />
					(
					<xsl:value-of select="xqdoc:module/@type" />
					module)
					<small class="pull-right">
                        xqdoc
                        <a href="../../doc/app/{$app}/server/xqdoc?fmt=xml&amp;path={$path}"
                            target="dn" title="{$path}">
                            <i class="glyphicon glyphicon-save"></i>
                        </a>
                    </small>
				</h2>
				<table>
					<tr>
						<td>
							<b>URI:</b>
						</td>
						<td>
							<code>
								<xsl:value-of select="xqdoc:module/xqdoc:uri" />
							</code>
						</td>
					</tr>
					<tr>
						<td>
							<b>Description:</b>
						</td>
						<td>
							<xsl:value-of select="xqdoc:module/xqdoc:comment/xqdoc:description" />
						</td>
					</tr>
					<tr>
						<td>
							<b>Author:</b>
						</td>
						<td>
							<xsl:value-of select="xqdoc:module/xqdoc:comment/xqdoc:author" />
						</td>
					</tr>
					<tr>
						<td>
							<b>Version:</b>
						</td>
						<td>
							<xsl:value-of select="xqdoc:module/xqdoc:comment/xqdoc:version" />
						</td>
					</tr>
					<tr>
						<td>
							<b>Imports:</b>
						</td>
						<td>
							<xsl:apply-templates select="//xqdoc:import" mode="link"/>
						</td>
					</tr>
				</table>
				<h2>Variables</h2>
				<xsl:apply-templates select="xqdoc:variables/xqdoc:variable">
					<xsl:sort select="xqdoc:name" />
				</xsl:apply-templates>

				<h2>Functions</h2>
				<xsl:apply-templates select="xqdoc:functions/xqdoc:function">
					<xsl:sort select="xqdoc:name" />
				</xsl:apply-templates>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="xqdoc:variable">
		<h3>
			<a class="anchor" id="cmp-{xqdoc:name}"></a>
			<a ng-click="scrollTo('cmp-{xqdoc:name}')">
				<xsl:value-of select="xqdoc:name" />
			</a>
		</h3>
		<table>
			<tr>
				<td>
					<b>Type:</b>
				</td>
				<td>
					<code>item()</code>
				</td>
			</tr>
			<xsl:apply-templates select="xqdoc:comment/xqdoc:description" />

		</table>
	</xsl:template>

	<xsl:template match="xqdoc:function">
		<h3>
			<!-- <xsl:value-of select="xqdoc:signature" /> -->
			<a class="anchor" id="cmp-{xqdoc:name}"></a>
			<a ng-click="scrollTo('cmp-{xqdoc:name}')">
				<xsl:value-of select="xqdoc:name" />
				<xsl:text>#</xsl:text>
				<xsl:value-of select="count(xqdoc:parameters/xqdoc:parameter)" />
			</a>

		</h3>
		<table>
			<xsl:apply-templates select="xqdoc:parameters" />

			<tr>
				<td>
					<b>Returns:</b>
				</td>
				<td>
					<table>
						<tr>
							<td>
								<xsl:apply-templates select="xqdoc:return/xqdoc:type" />
							</td>
							<td>
								<xsl:value-of select="xqdoc:comment/xqdoc:return" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<xsl:apply-templates select="xqdoc:comment/xqdoc:description" />
		</table>
	</xsl:template>

	<xsl:template match="xqdoc:description">
		<tr>
			<td>
				<b>Description:</b>
			</td>
			<td>
				<xsl:value-of select="." />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="xqdoc:parameters">
		<tr>
			<td>
				<b>Arguments:</b>
			</td>
			<td>

				<table>
					<xsl:for-each select="xqdoc:parameter">
						<tr>
							<td>
								<code>
									<xsl:value-of select="xqdoc:name" />
								</code>
							</td>
							<td>
								<xsl:apply-templates select="xqdoc:type" />
							</td>
							<td>
								<!-- @TODO better -->
								<xsl:value-of select="../xqdoc:comment/xqdoc:param/text()" />
							</td>
						</tr>

					</xsl:for-each>
				</table>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="xqdoc:type">
		<code>
			<xsl:value-of select="." />
			<xsl:value-of select="@occurance" />
		</code>
	</xsl:template>

	<xsl:template name="list">
		<xsl:param name="cmps" />
		<xsl:for-each select="$cmps">
			<xsl:sort select="lower-case(xqdoc:name)" />
			<xsl:apply-templates select="." mode="link" />
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="xqdoc:function" mode="link">
		<a ng-click="scrollTo('cmp-{xqdoc:name}')" class="label label-info"
			style="cursor:pointer;" title="{xqdoc:comment/xqdoc:description}">
			<xsl:value-of select="concat(xqdoc:name,'#')" />
		</a>
	</xsl:template>

    <xsl:template match="xqdoc:import" mode="link">
        <a ng-click="scrollTo('cmp-{xqdoc:uri}')" class="label label-info"
            style="cursor:pointer;" title="{xqdoc:comment/xqdoc:description}">
            <xsl:value-of select="xqdoc:uri" />
        </a>
    </xsl:template>
    
	<xsl:template match="xqdoc:variable" mode="link">
		<a ng-click="scrollTo('cmp-{xqdoc:name}')" class="label label-info"
			style="cursor:pointer;" title="{xqdoc:comment/xqdoc:description}">
			<xsl:value-of select="xqdoc:name" />
		</a>
	</xsl:template>

</xsl:stylesheet>
