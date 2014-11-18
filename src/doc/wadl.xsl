<?xml version="1.0" encoding="UTF-8"?>
<!-- basex wadl o/p to html with bootstrap -->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
	exclude-result-prefixes="xs wadl fn" version="2.0">

	<!-- root is initial path to ignore -->
	<xsl:param name="root" as="xs:string" />

	<!-- generate module html // -->
	<xsl:template match="/wadl:application/wadl:resources">
		<div class="row">
			<div class="col-md-4">
				<ul style="overflow:scroll">
					<xsl:for-each select="wadl:resource">
						<xsl:sort select="@path" />
						<li style="white-space:nowrap;">
							<xsl:apply-templates select="." mode="link">
								<xsl:with-param name="root" select="$root" />
							</xsl:apply-templates>
						</li>
					</xsl:for-each>
				</ul>
			</div>
			<div class="col-md-8" style="height:70vh;overflow:scroll;">

				<h2>
					RestXQ API:
					<xsl:value-of select="$root" />
					<small class="pull-right">
                        wadl.xml
                        <a href="../../doc/app/{$root}/server/wadl?fmt=xml"
                            target="dn">
                            <i class="glyphicon glyphicon-save"></i>
                        </a>
                    </small>
				</h2>

				<xsl:for-each select="wadl:resource">
					<xsl:sort select="@path" />
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="anchor" id="path-{generate-id()}"></a>
								<xsl:apply-templates select="." mode="link">
									<xsl:with-param name="root" select="$root" />
								</xsl:apply-templates>

								<p class="pull-right">
									<xsl:apply-templates
										select="wadl:method/wadl:response/wadl:representation" />
								</p>
							</h4>

						</div>

						<div class="panel-body">
							<xsl:value-of select="wadl:method/wadl:doc" />
							<xsl:apply-templates select="wadl:method" />
						</div>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="wadl:resource" mode="link">
		<xsl:param name="root" />
		<span class="pull-right">
        <xsl:call-template name="method-name" />
        </span> 
		<a ng-click="scrollTo('path-{generate-id()}')" title="{wadl:method/wadl:doc}">
			<span class="label label-info">
				<xsl:value-of select="substring(@path,1+string-length($root))" />
			</span>
		</a>
			
	</xsl:template>

	<xsl:template match="wadl:method">
		<xsl:apply-templates select="wadl:request" />
		<a target="_new" href="{../@path}">run</a>
		<button ng-click="run('{../@path}')">ang</button>
	</xsl:template>


	<xsl:template match="wadl:representation">
		<span class="label label-default">
			<xsl:value-of select="@mediaType" />
		</span>
	</xsl:template>

	<xsl:template match="wadl:request">
		<xsl:if test="wadl:param or ../../wadl:param">
			<h4>Parameters</h4>
			<table class="table">
				<thead>
					<tr>
						<th>Parameter</th>
						<th>Value</th>
						<th>Description</th>
					</tr>
				</thead>
				<xsl:for-each select="../../wadl:param | wadl:param">
					<xsl:sort select="@name" />
					<tr>
						<td>
							<xsl:value-of select="@name" />
						</td>
						<td>
							<input type="text" name="{@name}" />
							<xsl:value-of select="@style" />
						</td>
						<td>
							?
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</xsl:if>

	</xsl:template>

	<xsl:template name="method-name">
		<xsl:variable name="name" select="wadl:method/@name" />
		<span>
			<xsl:attribute name="class">
		<xsl:text>wadl-method label </xsl:text>
			<xsl:choose>
				<xsl:when test="$name='GET'">
					<xsl:text>label-primary</xsl:text>
				</xsl:when>
				<xsl:when test="$name='POST'">
					<xsl:text>label-success</xsl:text>
				</xsl:when>
				<xsl:when test="$name='DELETE'">
					<xsl:text>label-danger</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>label-warning</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:attribute>
			<xsl:value-of select="wadl:method/@name" />
		</span>
	</xsl:template>
</xsl:stylesheet>
