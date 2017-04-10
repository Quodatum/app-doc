// database info
angular.module('quodatum.doc.database', [ 'ui.router', 'restangular', 'quodatum.services'])

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider
          .state('database', {
            url : "/data/database",
            abstract : true,
            template : '<ui-view>Database list</ui-view>',
            data : {
              entity : "database"
            }
          })

          .state('database.index', {
            url : "",
            templateUrl : '/static/doc/feats/database/database-list.html',
            controller : "DatabaseListCtrl",
            ncyBreadcrumb : {
              label : 'Databases'
            }
          })
         
          .state('database.item', {
            url : "/:database",
            templateUrl : '/static/doc/feats/database/database.html',
            reloadOnSearch : false,
            ncyBreadcrumb : {
              label : '{{$stateParams.database}}',
              parent : 'database.index'
            },
            controller : "DatabaseCtrl"
          })
        } ])

// controllers
.controller(
    "DatabaseListCtrl",
    [ "$scope", "$stateParams","DiceService", function($scope, $stateParams,DiceService) {
      console.log("DatabaseListCtrl");
      function update() {
        DiceService.list('database', $scope.params).then(function(d) {
          // console.log("models..",d);
          $scope.databases = d;
        });
      }

      DiceService.setup($scope, update);
    }]
    )
    
.controller(
    "DatabaseCtrl",
    [ "$scope",  "$stateParams", 'DiceService',
        function($scope,  $stateParams,DiceService) {
          var database = $stateParams.database;
          console.log("job control: ", database);
          $scope.setTitle("Database: " + database);
            DiceService.one("database", $stateParams.database).then(function(d) {
              $scope.model = d
            });
        } ])
    
;
