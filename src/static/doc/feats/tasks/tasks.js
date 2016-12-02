// tasks
angular.module('quodatum.doc.tasks',
    [ 'ui.router', 'restangular', 'angular-growl' ])
    
.config(
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
            data : {
              entity : "task"
            }
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
    [
        "$scope",
        "$location",
        "TaskService",
        "growl",
        function($scope, $location, TaskService, growl) {
          console.log("task control");
          $scope.setTitle("Run Tasks");
          $scope.params = {
            start : 0
          };
          growl.info("This page uses angular growl for notifications");

          $scope.run = function(task) {
            TaskService.run(task).then(function(r) {
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
            TaskService.list($scope.params).then(
                function(d) {
                  $scope.tasks = d;
                });
          }
          ;
        } ])

// details of a task
.controller(
    "TaskCtrl",
    [ "$scope", "TaskService", "$stateParams", "growl",
        function($scope, TaskService, $stateParams, growl) {
          var task = $stateParams.task;
          console.log("task control: ", task);
          $scope.setTitle("Run Task" + task);
          TaskService.get(task).then(function(d) {
            console.log("task control", d);
            $scope.data = d;
            TaskService.text(d.path).then(function(d) {
              console.log("task text", d);
              $scope.source = d;
            });
          });
          
          $scope.run = function(task,opt) {
            TaskService.run(task,opt).then(function(r) {
              console.log("TASK DONE");
              growl.success(r);

            }, function(r) {
              growl.error(r.data);
            })
          };
        } ])

// details of a task
.controller(
    "AsyncCtrl",
    [ "$scope", "Restangular", "$stateParams", "growl",
        function($scope, Restangular, $stateParams, growl) {
          console.log("async control");
          var task = $stateParams.task;
          $scope.setTitle("Run Task" + task);
        } ])

// task api
.service('TaskService', [ 'Restangular', function(Restangular) {
  this.get = function(task) {
    return Restangular.one("data").one("task", task).get();
  };
  this.run = function(task,opts) {
    return Restangular.all("task").all(task).post(null,opts);
};
  this.async = function(task) {
    alert("async");
    return Restangular.all("task").post(task,null,{mode:'async'});
  };
  this.list = function(params) {
    return Restangular.one("data").all("task").getList(params);
  };
  this.text = function(path) {
    return Restangular.oneUrl("data/file/read").get({path:path});
  };
} ]);
