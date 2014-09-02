declare  variable $body external;
declare  variable $version external;
declare variable $base external :="/doc/";
declare variable $static external :="/static/doc/";

<html ng-app="doc" ng-controller="AppController">
<head>
 <meta charset="utf-8"/>
 <base href="{$base}" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="doc"/>
<meta name="author" content="andy bunce"/>
    
<title>doc (v{$version})</title>
<!-- Le fav and touch icons -->
<link rel="shortcut icon" href="app.ico"/>
<link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.css" rel="stylesheet" type="text/css" />  
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="{$static}../lib/oci.treeview/20140305/treeview.css" rel="stylesheet" type="text/css" />
<link href="{$static}../lib/angular-ya-treeview/0.2.1/ya-treeview-0.2.1.css" rel="stylesheet" type="text/css" />    
<link href="{$static}app.css" rel="stylesheet"/>

<script type="text/javascript">
  (function(i,s,o,g,r,a,m){{i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){{
  (i[r].q=i[r].q||[]).push(arguments)}},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  }})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-39638120-1', 'auto');
</script>   
</head>
<body> 
{$body}

     <!-- angular -->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular.min.js"  ></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-resource.min.js"  ></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-cookies.min.js"  ></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-sanitize.min.js"></script> 
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-route.min.js"></script> 
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-animate.min.js"></script> 
    <!-- others -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.10.0/ui-bootstrap-tpls.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/2.4.1/lodash.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/restangular/1.3.1/restangular.min.js"  ></script>
   
    <!-- local libs -->
    <script src="{$static}../lib/oci.treeview/20140305/treeview.js"  ></script>
    <script src="{$static}../lib/angular-ya-treeview/0.2.1/ya-treeview-0.2.1-tpls.js"  ></script>
   
    <script src="{$static}app.js"  ></script>
    <script src="{$static}feats/apps/apps.js"  ></script>
    <script src="{$static}feats/components/components.js"  ></script>
    <script src="{$static}feats/files/files.js"  ></script>
</body>
</html>