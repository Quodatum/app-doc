// access local indexedDB history info
angular.module('quodatum.history', [ 'ui.router', 'ngdexie' ]).config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('history', {
            url : "/data/history",
            abstract : true,
            template : '<ui-view>history</ui-view>',
            ncyBreadcrumb : {
              skip : true
            }
          })

          .state('history.index', {
            url : "",
            templateUrl : '/static/doc/feats/history/historylist.xml',
            controller : "HistoryListCtrl",
            reloadOnSearch : false,
            ncyBreadcrumb : {
              label : 'History'
            },
            data : {
              "history" : false
            }
          })

        } ])

// controllers
.controller(
    "HistoryListCtrl",
    [
        '$stateParams',
        '$scope',
        '$location',
        'ngDexie',
        function($stateParams, $scope, $location, ngDexie) {
          $scope.sortopts = [ {
            name : "id",
            label : "id"
          }, {
            name : "timestamp",
            label : "timestamp"
          } ];
          $scope.params = {
            start : 0,
            sort : "name"
          };

          console.log("HistoryListCtrl");
          $scope.$watch('params', function(value) {
            $location.search($scope.params);
            update();
          }, true);
          function update() {
            ngDexie.getDb(function(db) {
              db.log.toCollection().reverse().limit(20).offset(
                  $scope.params.start).toArray()

              .then(function(data) {
                // console.log("------------",data);
                $scope.$apply(function() {
                  $scope.history = data;
                });
              });
            })
          }
          ;
          $scope.dropall = function() {
            ngDexie.getDb(function(db) {
              db.log.clear().then(function(n) {
                update();
              })
            })
          };
        } ])
