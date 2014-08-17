declare  variable $body external;
declare  variable $version external;
<html ng-app="app-doc" ng-controller="AppController">
<head>
 <meta charset="utf-8"/>
 <base href="/static/app-doc/" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="app-doc"/>
<meta name="author" content="andy bunce"/>
    
<title>app-doc (v{$version})</title>
<!-- Le fav and touch icons -->
<link rel="shortcut icon" href="app.ico"/>


<link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.css" rel="stylesheet" type="text/css" />  
<link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.min.css" rel="stylesheet" type="text/css" />  
<link href="/static/lib/angular-tree-control/0.2.0/css/tree-control.css" rel="stylesheet"/>
<link href="/static/lib/ui-layout/0.0.1/ui-layout.css" rel="stylesheet"/>
<link href="/static/app-doc/app.css" rel="stylesheet"/>

<script type="text/javascript">
  (function(i,s,o,g,r,a,m){{i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){{
  (i[r].q=i[r].q||[]).push(arguments)}},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  }})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-39638120-1', 'auto');
</script>   
</head>
<body> 
<div class="container">
      <div class="navbar navbar-inverse" role="navigation">
        <div class="container-fluid">
          
          <div class="navbar-header"> 
            <a class="navbar-brand" href="/app-doc/">
            <img src="/static/app-doc/app-doc.svg" style="width:20px;height:20px" />
            app-doc</a>          
          </div>
          
            <ul class="nav navbar-nav" >                
                <li><a href="#/xslt"><i class="fa fa-shield"></i> XSLT</a></li>
                <li><a href="#/schema"><i class="fa fa-comment"></i> Schema</a></li>
                <li><a href="#/xquery"><i class="fa fa-home"></i> XQuery</a></li>
                <li><a href="#/schematron"><i class="fa fa-home"></i> Schematron</a></li>
                <li><a href="#/repl"><i class="fa fa-home"></i> REPL</a></li>
            </ul>
         </div>
        </div>      
        {$body}
</div>
<!-- 
     <script src="//cdn.jsdelivr.net/ace/1.1.4/noconflict/ace.js"></script>
     <script src="//cdn.jsdelivr.net/ace/1.1.4/noconflict/ext-language_tools.js"></script>
     -->
       <script src="/static/lib/ace/03.08.2014/src-min-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
    <script src="/static/lib/ace/03.08.2014/src-min-noconflict/ext-language_tools.js" type="text/javascript" charset="utf-8"></script>
   <script src="/static/lib/ace/03.08.2014/src-min-noconflict/ext-settings_menu.js" type="text/javascript" charset="utf-8"></script>
  <script src="/static/lib/ace/03.08.2014/src-min-noconflict/ext-keybinding_menu.js" type="text/javascript" charset="utf-8"></script>
     
     <script src="/static/app-doc/js/acebits.js"  ></script>
             
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js" type="text/javascript"></script>
   <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.min.js" type="text/javascript"></script>

     <script src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/1.3.1/lodash.min.js" type="text/javascript"></script>
     <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.4.0/moment.min.js" type="text/javascript"></script>
     <!-- angular -->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular.js"  ></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-resource.min.js"  ></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-cookies.min.js"  ></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-sanitize.min.js"></script> 
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-route.min.js"></script> 
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.13/angular-animate.min.js"></script> 
    <!-- others -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.10.0/ui-bootstrap-tpls.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/restangular/1.3.1/restangular.min.js"  ></script>
   
    <!-- local libs -->
     <script src="/static/lib/angular-tree-control/0.2.0/angular-tree-control.js"></script>
    <script src="/static/lib/ui-layout/0.0.1/ui-layout.js"></script>
    <script src="/static/lib/ui-ace/0.1.0/ui-ace.js"></script>
    <script src="/static/lib/angular-flashr/0.0.5/angular-flashr.js"></script> 
    <script src="/static/app-doc/js/directives.js"  ></script>
    <script src="/static/app-doc/app.js"  ></script>
    
    <script src="/static/app-doc/feats/tree/tree.js"  ></script>
    <script src="/static/app-doc/feats/xslt/xslt.js"  ></script>
</body>
</html>