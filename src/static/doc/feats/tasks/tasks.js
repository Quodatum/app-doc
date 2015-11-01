// tasks
angular.module('quodatum.doc.tasks',
    [ 'ui.router', 'restangular', 'angular-growl', 'treemendous' ]).config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('tasks', {
            url : "/tasks",
            abstract : true,
            template : '<ui-view>tasks</ui-view>',
            ncyBreadcrumb : {
              skip : true
            },
            data:{entity:"task"}
          })

          .state('tasks.index', {
            url : "",
            templateUrl : '/static/doc/feats/tasks/tasks.html',
            controller : "TaskCtrls",
            ncyBreadcrumb : {
              label : 'tasks'
            }
          })

          .state('tasks.item', {
            url : "/:task",
            templateUrl : '/static/doc/feats/tasks/task.xhtml',
            reloadOnSearch : false,
            ncyBreadcrumb : {
              label : '{{$stateParams.task}}',
              parent : 'tasks.index'
            },
            controller : "TaskCtrl"
          })

            .state('async', {
            url : "/async",
            templateUrl : '/static/doc/feats/tools/async.xhtml',
            reloadOnSearch : false,
            controller : "AsyncCtrl"
          })
        } ])

// controllers
.controller(
    "TaskCtrls",
    [ "$scope", "$location", "Restangular", "growl",
        function($scope, $location, Restangular, growl) {
          console.log("task control");
          $scope.setTitle("Run Tasks");
          $scope.params = {
            start : 0
          };
          growl.info("This page uses angular growl for notifications");

          $scope.run = function(task) {
            Restangular.all("task").all(task).post().then(function(r) {
              console.log("TASK DONE");
              growl.success(r);

            }, function(r) {
              growl.error(r.data);
            })
          };

          $scope.$watch('params', function(value) {
            $location.search($scope.params);
            update();
          }, true);

          function update() {
            Restangular.one("data").all("task").getList().then(function(d) {
              $scope.tasks = d;
            });
          }
          ;
        } ])

// details of a task
.controller(
    "TaskCtrl",
    [ "$scope", "Restangular", "$stateParams", "growl",
        function($scope, Restangular, $stateParams, growl) {
          console.log("task control");
          var task = $stateParams.task;
          $scope.setTitle("Run Task" + task);
          Restangular.one("data").one("task", task).get().then(function(d) {
            console.log("task control", d);
            $scope.data = d;
          });
          
          $scope.run = function(task) {
            Restangular.all("task").all(task).post().then(function(r) {
              console.log("TASK DONE");
              growl.success(r);

            }, function(r) {
              growl.error(r.data);
            })
          };
        }
    ])

// details of a task
.controller(
    "AsyncCtrl",
    [ "$scope", "Restangular", "$stateParams", "growl",
        function($scope, Restangular, $stateParams, growl) {
          console.log("async control");
          var task = $stateParams.task;
          $scope.setTitle("Run Task" + task);
        } ]);
