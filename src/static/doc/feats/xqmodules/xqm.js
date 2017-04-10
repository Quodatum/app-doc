// app info
angular.module('quodatum.doc.xqm',
    [ 'ui.router',  'quodatum.services' ])

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('xqmodule', {
            url : "/data/xqmodule",
            abstract : true,
            template : '<ui-view>library</ui-view>',
            data : {
              entity : "xqmodule"
            }
          })

          .state('xqmodule.index', {
            url : "",
            templateUrl : '/static/doc/feats/xqmodules/xqms.html',
            controller : "XqmsCtrl",
            ncyBreadcrumb : {
              label : 'XQ Modules'
            }
          })

          .state('xqmodule.module', {
            url : "/item?item",
            templateUrl : '/static/doc/feats/xqmodules/xqm1.html',
            controller : "XqmCtrl",
            ncyBreadcrumb : {
              label : '{{$stateParams.item}}',
              parent : 'xqmodule.index'
            }
          })
        } ])

// controllers
.controller("XqmsCtrl",
    [ "$scope", "DiceService", function($scope, DiceService) {

      console.log("XqmCtrl2");

      function update() {
      console.log("XQ req", $scope.params);
        DiceService.list('xqmodule', $scope.params).then(function(d) {
          // console.log("AppsCtrl2", d);
          $scope.apps = d;
        });
      }
      DiceService.setup($scope, update)

    } ])

.controller(
    "XqmCtrl",
    [ "$scope", "$stateParams", "DiceService",
        function($scope, $stateParams, DiceService) {
          var item = $stateParams.item;
          console.log("xqmCtrl", item);

          var applist = DiceService.one('xqmodule','item',{item:item})
         .then(function(d) {
            $scope.xqmodule = d;
            console.log("xqmCtrl >>", d);
          });

        } ])

.controller(
    'XqmCtrl2',
    [ "$scope", "$stateParams", "ScrollService", "$log", "$location",
        function($scope, $stateParams, ScrollService, $log, $location) {
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
          $scope.scrollTo = ScrollService.scrollTo;
        } ]);
