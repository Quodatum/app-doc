// app info
angular.module('quodatum.doc.apps',
    [ 'ui.router', 'restangular', 'quodatum.services' ])
    
    .config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider
          
          .state('app', {
            url : "/data/app",
            abstract : true,
            template : '<ui-view>App list</ui-view>',
            ncyBreadcrumb: { skip:true}
          })

          .state('app.index', {
            url : "",
            templateUrl : '/static/doc/feats/apps/apps.xhtml',
            controller : "AppsCtrl",
		    ncyBreadcrumb: { label: 'Apps'}
          })

          .state('app.item', {
            url : "/:app",
			abstract : true,
			template : '<ui-view>App detail</ui-view>',
            ncyBreadcrumb: { label: '{{app.name}}'}
          })
		  
           .state('app.item.index', {
            url : "",
			templateUrl : '/static/doc/feats/apps/app-index.xhtml',
			controller : "AppCtrl",
			ncyBreadcrumb: { label: 'is {{app.name}}',parent: 'app.index'}
          })
		  
           .state('app.item.client', {
            url : "/client",
            templateUrl : '/static/doc/feats/apps/client.xhtml',
            controller : "AppCtrl2",
			ncyBreadcrumb: { label: 'is {{app}',parent: 'app.index' }
          })
		  
            .state('app.item.server', {
            url : "/server",
            templateUrl : '/static/doc/feats/apps/server.xhtml',
            controller : "AppCtrl2"
          })
          .state('app.item.wadl', {
            url : "/rest",
            templateUrl : function ($stateParams){
              return '/doc/app/' + $stateParams.app + '/server/wadl';
            },
           
			ncyBreadcrumb: { label: 'is {{app}',parent: 'app.index' },
			controller:"ScrollCtrl"
          })
           .state('app.item.component', {
            url : "/component",
            templateUrl : function ($stateParams){
              return '/doc/app/' + $stateParams.app + '/client/components';
            },
            ncyBreadcrumb: { label: 'is {{app}',parent: 'app.index' },
            controller:"ScrollCtrl"
          })
           .state('app.item.template', {
            url : "/template",
            templateUrl : function ($stateParams){
              return '/doc/app/' + $stateParams.app + '/client/templates';
            },
			ncyBreadcrumb: { label: 'is {{app}',parent: 'app.index' }
          })
          
          .state('app.item.xqdoc', {
            url : "/xqdoc",
            templateUrl : function ($stateParams){
              return '/doc/data/app/' + $stateParams.app + '/server/xqdoc';
            },
			ncyBreadcrumb: { label: 'is {{app}',parent: 'app.index' }
          })
          

        } ])


// controllers
.controller("AppsCtrl",
    [ "$scope", "Restangular", function($scope, Restangular) {

      console.log("AppsCtrl2");
   
      var applist = Restangular.one("data").all('app');
      applist.getList().then(function(d) {
        // console.log("AppsCtrl2", d);
        $scope.apps = d;
      });

    } ])

.controller(
    "AppCtrl",
    [ "$scope", "$stateParams", "Restangular",
        function($scope, $stateParams, Restangular) {
          var app = $stateParams.app;
          console.log("AppCtrl", app);

          var applist = Restangular.one("data").one('app', app);
          applist.get().then(function(d) {
            $scope.app = d.item;
            console.log(">>", d);
          });
        } ])

.controller(
    'AppCtrl2',
    [ "$scope", "$stateParams", "ScrollService", "$log",
        function($scope, $stateParams, ScrollService, $log) {
          $log.log("View:", $stateParams.view);
          var app = $stateParams.app;
          var map = {
            "xqdoc" : '/server/xqdoc',
            "wadl" : '/server/wadl',
            "components" : '/client/components',
            "templates" : '/client/templates',
            "xqdoc2" : 'doc/server'
          };
          $scope.view = $stateParams.view;
          $scope.app = $stateParams.app;
          var searchObject = $location.search(); // {path:"dd",type:"basex"}
          console.log("search:", searchObject);
          var target = "../../doc/app/" + app + map[$stateParams.view];
          if (searchObject.path) {
            target += "?path=" + $stateParams.path;
          }
          if (searchObject.type) {
            target += "&type=" + searchObject.type;
          }
          $scope.inc = target;
          console.log("TAR", target);
          $scope.setTitle("docs");
          $scope.scrollTo = ScrollService.scrollTo
        } ]);
