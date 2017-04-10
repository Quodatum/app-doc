// tasks
angular.module('quodatum.doc.tasks',
    [ 'ui.router', 'restangular', 'angular-growl', 'quodatum.services' ])
    
.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('task', {
            url : "/task",
            abstract : true,
            template : '<ui-view>tasks</ui-view>',
            ncyBreadcrumb : {
              skip : true
            },
            data : {
              entity : "task"
            }
          })

          .state('task.index', {
            url : "",
            templateUrl : '/static/doc/feats/tasks/tasks.html',
            controller : "TasksCtrl",
            ncyBreadcrumb : {
              label : 'tasks'
            }
          })

          .state('task.item', {
            url : "/:task",
            templateUrl : '/static/doc/feats/tasks/task.xhtml',
            reloadOnSearch : false,
            ncyBreadcrumb : {
              label : '{{$stateParams.task}}',
              parent : 'task.index'
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
    "TasksCtrl",
    [
        "$scope",
        "$location",
        "TaskService","DiceService",
        "growl",
        function($scope, $location, TaskService,DiceService, growl) {
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

          function update() {
            TaskService.list($scope.params).then(
                function(d) {
                  $scope.tasks = d;
                });
          }
          ;
          DiceService.setup($scope, update);
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
            TaskService.text(d.url).then(function(d) {
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
