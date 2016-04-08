declare  variable $body external :="{body}";
declare  variable $version external :="{verson}";
declare variable $base external :="/doc/";
declare variable $static external :="/static/doc/";
declare variable $incl-css as element()* external :=();
declare variable $incl-js as element()* external :=();
declare variable $debug-js as element()* external :=();

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
<link rel="shortcut icon" href="{$static}icon.png"/>
<!-- component css -->
{$incl-css}
<link href="{$static}app.css" rel="stylesheet"/>
<!--
<script type="text/javascript" src="/static/lib/firebug-lite/4/firebug-lite.js">
{{
    overrideConsole: false,
    startInNewWindow: true,
    startOpened: true,
    enableTrace: true
}}
</script>
-->
<script type="text/javascript">
  (function(i,s,o,g,r,a,m){{i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){{
  (i[r].q=i[r].q||[]).push(arguments)}},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  }})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-39638119-1', 'auto');
</script>   
</head>
<body> 
{$body}

 <!-- start component js -->
    {$incl-js}
    <!-- application -->
    <script src="{$static}app.js"  ></script>
    <script src="{$static}services.js"  ></script>
    <script src="{$static}api.js"  ></script>
    <script src="{$static}feats/apps/apps.js"  ></script>
    <script src="{$static}feats/components/components.js"  ></script>
	<script src="{$static}feats/history/history.js"  ></script>
    <script src="{$static}feats/files/files.js"  ></script>
    <script src="{$static}feats/schema/schema.js"  ></script>
    <script src="{$static}feats/entity/entity.js"  ></script>
    <script src="{$static}feats/xqmodules/xqm.js"  ></script>
    <script src="{$static}feats/tools/tools.js"  ></script>
    <script src="{$static}feats/tasks/tasks.js"  ></script>
    <script src="{$static}feats/directives/directives.js"  ></script>
</body>
</html>