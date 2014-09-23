# Doc app dev guide

Web UI set in doc-rest.xqm
UI is created in layout.xqm
Angular app is <html ng-app="doc" ng-controller="AppController">

## json interface
uses dice framework

## cva bars 
A UI component. Crumbs,Views,Actions
Has an XML respresentation.
lib/cva.xqm can load from a conventional location and format for json 

##xslt 
Anchor
<a class="anchor" id="cmp-{@name}"/>
<a ng-click="scrollTo('cmp-{@name}')">
    <xsl:value-of select="@name" />
</a>

## Framework
An application has a name. The name must be a valid folder name 
server uses BaseX with RESTXQ
client uses Angularjs
Code layout
/app
/static/app

#restangular One vs All

#metadata
A conforming application should provide the following files at the root:
- expath-pkg.xml
- repo.xml The ExistDb application descriptor 

