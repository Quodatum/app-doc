# Doc app dev guide
* [general](doc.md)
* [client](client/readme.md)
* [server](server/readme.md)

Web UI set in doc-rest.xqm
UI is created in layout.xqm
Angular app is <html ng-app="doc" ng-controller="AppController">


## Framework
An application has a name. The name must be a valid folder name 
server uses BaseX with RESTXQ
client uses Angularjs
Code layout
/app
/static/app

## json interface
uses dice framework
generic request parameters

| name  | default | description                 |
|-------|---------|-----------------------------|
| sort  |         | [+/-]field  name to sort on |
| start | 0       | 1st,item to return          |
| limit | 30      | max items to return         |



## cva bars 
A UI component. Crumbs,Views,Actions


##xslt 
Anchor
<a class="anchor" id="cmp-{@name}"/>
<a ng-click="scrollTo('cmp-{@name}')">
    <xsl:value-of select="@name" />
</a>

$scope.scrollTo = function(id) {
        //$log.log("DDDD", id);
        $location.hash(id);
        // call $anchorScroll()
        $anchorScroll();
    };
          


#restangular One vs All

configured in app.js
RestangularProvider.setBaseUrl('.');
getlist looks for 
data.metadata = {count : response.total,crumbs:".."}

#metadata
A conforming application should provide the following files at the root:
- expath-pkg.xml
- repo.xml The ExistDb application descriptor
in static 
- logo.svg
## 

