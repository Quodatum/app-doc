// app info
angular.module('quodatum.doc.apps', [ 'ui.router', 'quodatum.services' ])

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('app', {
            url : "/data/app",
            abstract : true,
            template : '<ui-view>App list</ui-view>',
            data : {
              entity : "app"
            }
          })

          .state('app.index', {
            url : "",
            templateUrl : '/static/doc/feats/apps/apps.xhtml',
            controller : "AppsCtrl",
            ncyBreadcrumb : {
              label : 'Apps'
            }
          })

          .state('app.item', {
            url : "/:app",
            abstract : true,
            template : '<ui-view>App detail</ui-view>',
            ncyBreadcrumb : {
              label : '{{app.name}}'
            }
          })

          .state('app.item.index', {
            url : "",
            templateUrl : '/static/doc/feats/apps/app-index.html',
            controller : "AppCtrl",
            ncyBreadcrumb : {
              label : '{{$stateParams.app}}',
              parent : 'app.index'
            }
          })

          .state('app.item.client', {
            url : "/client",
            abstract : true,
            template : '<ui-view>client</ui-view>',
            ncyBreadcrumb : {
              label : 'client',
              parent : 'app.item.index'
            }
          })

          .state('app.item.server', {
            url : "/server",
            abstract : true,
            template : '<ui-view>server</ui-view>',
            ncyBreadcrumb : {
              label : 'server',
              parent : 'app.item.index'
            }
          })

          .state('app.item.server.rest', {
            url : "/rest",
            templateUrl : '/static/doc/feats/apps/app-rest.xhtml',
            ncyBreadcrumb : {
              label : 'restXQ'
            },
            controller : "RestCtrl"
          })

          .state('app.item.client.component', {
            url : "/:view",
            templateUrl : '/static/doc/feats/apps/app-view.xhtml',
            ncyBreadcrumb : {
              label : 'view: {{$stateParams.view}}'
            },
            controller : "ScrollCtrl"
          }).state('app.item.client.template', {
            url : "/:view",
            templateUrl : '/static/doc/feats/apps/app-view.xhtml',
            ncyBreadcrumb : {
              label : 'view: {{$stateParams.view}}'
            },
            controller : "ScrollCtrl"
          })

          .state('app.item.server.xqdoc', {
            url : "/:view",
            templateUrl : '/static/doc/feats/apps/app-view.xhtml',
            ncyBreadcrumb : {
              label : 'view: {{$stateParams.view}}'
            },
            controller : "ScrollCtrl"
          })

          .state('app.item.server.wadl', {
            url : "/:view",
            templateUrl : '/static/doc/feats/apps/app-view.xhtml',
            ncyBreadcrumb : {
              label : 'view: {{$stateParams.view}}'
            },
            controller : "ScrollCtrl"
          })

        } ])

// controllers
.controller("RestCtrl",
    [ "$scope", "DiceService", function($scope, DiceService) {
      console.log("RestCtrl");

      function update() {
        /*
         * Restangular.one("data").all('app') .getList($scope.params)
         * .then(function(d){ //console.log("models..",d); $scope.apps=d; });
         */
      }
      DiceService.setup($scope, update)
    } ])

.controller("AppsCtrl",
    [ "$scope", "DiceService", function($scope, DiceService) {
      // console.log("AppsCtrl2");

      function update() {
        DiceService.list('app', $scope.params).then(function(d) {
          // console.log("models..",d);
          $scope.apps = d;
        });
      }

      DiceService.setup($scope, update);
    } ])

.controller(
    "AppCtrl",
    [ "$scope", "$stateParams", "DiceService",
        function($scope, $stateParams, DiceService) {
          var app = $stateParams.app;
          console.log("AppCtrl", app);
          $scope.server = [ {
            state : "app.item.server.wadl({view:'wadl'})",
            label : "Endpoints"
          }, {
            state : "app.item.server.xqdoc({view:'xqdoc'})",
            label : "XQdoc"
          }, {
            state : "app.item.server.wadl({view:'wadl'})",
            label : "Endpoints"
          } ]
          DiceService.one('app', app).then(function(d) {
            $scope.app = d;
            // console.log(">>", d);
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