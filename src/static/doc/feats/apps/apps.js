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
            template : '<ui-view>library</ui-view>'
          })

          .state('app.index', {
            url : "",
            templateUrl : '/static/doc/feats/apps/apps.xhtml',
            controller : "AppsCtrl"
          })

          .state('app.item', {
            url : "/:app",
            templateUrl : '/static/doc/feats/apps/app1.xhtml',
            controller : "AppCtrl"
          })
          
           .state('app.item.client', {
            url : "/client",
            templateUrl : '/static/doc/feats/apps/client.xhtml',
            controller : "AppCtrl2"
          })
            .state('app.item.server', {
            url : "/server",
            templateUrl : '/static/doc/feats/apps/server.xhtml',
            controller : "AppCtrl2"
          })
          .state('app.item.wadl', {
            url : "/rest",
            templateUrl : function ($stateParams){
              return '/doc/data/app/' + $stateParams.app + '/server/wadl';
            }
          })
            .state('app.item.view', {
            url : "/view",
            templateUrl : '/static/doc/feats/apps/app-view.xhtml',
            controller : "AppCtrl2"
          })
        } ])


// controllers
.controller("AppsCtrl",
    [ "$scope", "Restangular", function($scope, Restangular) {

      console.log("AppsCtrl2");
      var bar = Restangular.one("meta").one("cvabar", "apps-bar");
      bar.get().then(function(d) {
        $scope.bar = d;
      });
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
          var bar = Restangular.one("meta").one("cvabar", "app-bar");
          bar.get().then(function(d) {
            $scope.bar = d;
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
