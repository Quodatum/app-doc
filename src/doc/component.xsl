<xsl:stylesheet version="2.0" xmlns:pkg="http://expath.org/ns/pkg"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- convert components.xml to bootstrap html -->
	<xsl:template match="/components">
		<div>
			<h2>
				Components (
				<xsl:value-of select="count(cmp)" />
				)
			</h2>
			<div>
				<xsl:apply-templates select="cmp">
					<xsl:sort select="lower-case(@name)" />
				</xsl:apply-templates>
			</div>
			<h2>Errors</h2>
			<xsl:for-each select="//depends[not(. =//cmp/@name)]">
				<span class="label label-danger">
					<xsl:value-of select="." />
				</span>
			</xsl:for-each>
		</div>
	</xsl:template>
<!-- convert package.xml to bootstrap html -->
	<xsl:template match="/pkg:package">
		<xsl:variable name="cmps" select="doc('data/components.xml')//cmp" />
		<xsl:variable name="used" select="pkg:dependency" />
		<xsl:variable name="found" select="$cmps[@name=$used/@name]" />
		<div>
			<h2>
				<span class="label label-primary"><xsl:value-of select="@abbrev" /></span>
				lists <span class="label label-default"><xsl:value-of select="count($used)" /></span>			
				dependancies in package.xml<a href="../../doc/app/{@abbrev}/client/components?fmt=xml" target="dn"><i class="glyphicon glyphicon-save"></i></a>
			</h2>
			<xsl:for-each select="$used">
			     <xsl:sort select="lower-case(@name)" />
			     <xsl:variable name="cmp" select="$cmps[@name=current()/@name]" />
			     
				<a ng-click="scrollTo('cmp-{@name}')"
				class="btn btn-sm btn-{if($cmp)then 'success' else 'danger'}">
				<xsl:value-of select="@name" />
				</a>
			</xsl:for-each>
			<div>
				<h3>Used</h3>
				<xsl:apply-templates select="$found">
					<xsl:sort select="lower-case(@name)" />
				</xsl:apply-templates>
			</div>
			<h3>
				Not used
				(
				<xsl:value-of select="count($cmps)" />
				)
			</h3>
			<div>
				<xsl:apply-templates select="$cmps except $found">
					<xsl:sort select="lower-case(@name)" />
				</xsl:apply-templates>
			</div>
		</div>
	</xsl:template>


	<xsl:template match="cmp">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a class="anchor" id="cmp-{@name}"></a>
					<a ng-click="scrollTo('cmp-{@name}')">
						<xsl:value-of select="@name" />
					</a>
					<xsl:for-each select="release" />
					<span class="badge">
						<xsl:value-of select="release/@version" />
					</span>

					<span class="pull-right">
						<a href="{home}" target="benchx-doc" class="badge">
							<i class="glyphicon glyphicon-home"></i>
							Home
						</a>
					</span>
				</h4>
			</div>
			<div class="panel-body">
				<p>
					<xsl:value-of select="tagline" />
				</p>

				<span>
					Licence:
					<span class="badge">
						<xsl:value-of select="licence" />
					</span>
				</span>
				<span>
					Runat:
					<span class="badge">
						<xsl:value-of select="runat" />
					</span>
				</span>

				<div>
					Used by:
					<xsl:for-each select="//cmp[depends=current()/@name]">
						<xsl:sort select="@name" />
						<a ng-click="scrollTo('cmp-{@name}')" class="label label-info">
							<xsl:value-of select="@name" />
						</a>
					</xsl:for-each>
				</div>
				<div>
					Depends on:
					<xsl:for-each select="depends">
						<xsl:sort select="@name" />
						<a ng-click="scrollTo('cmp-{.}')" class="label label-info">
							<xsl:value-of select="." />
						</a>
					</xsl:for-each>
				</div>
				<h5>Versions</h5>
				<ul>
					<xsl:apply-templates select="release" />
				</ul>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="local">
		Local:
		<xsl:apply-templates select="*" />
	</xsl:template>

	<xsl:template match="cdn">
		CDN:
		<xsl:apply-templates select="*" />
	</xsl:template>

	<xsl:template match="release">
		<li>
			<xsl:value-of select="@version" />
			<div>
				CDN:
				<a href="{cdn}">
					<xsl:value-of select="cdn" />
				</a>
			</div>
		</li>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>