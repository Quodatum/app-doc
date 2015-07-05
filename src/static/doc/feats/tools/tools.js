// database info
angular.module('quodatum.doc.tools',
    [ 'ui.router', 'restangular', 'angular-growl', 'treemendous' ]).config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('tasks', {
            url : "/tasks",
            abstract : true,
            template : '<ui-view>tasks</ui-view>'
          })

          .state('tasks.index', {
            url : "",
            templateUrl : '/static/doc/feats/tools/tasks.xhtml',
            reloadOnSearch : false,
            controller : "TaskCtrls"
          })

          .state('tasks.item', {
            url : "/:task",
            templateUrl : '/static/doc/feats/tools/task.xhtml',
            reloadOnSearch : false,
            controller : "TaskCtrl"
          })

          .state('poster', {
            url : "/poster",
            templateUrl : '/static/doc/feats/tools/poster.xhtml',
            reloadOnSearch : false,
            controller : "PostCtrl"
          })

        } ])

// controllers
.controller("TaskCtrls",
    [ "$scope", "Restangular", "growl", function($scope, Restangular, growl) {
      console.log("task control");
      $scope.setTitle("Run Tasks");
      $scope.params = {
        start : 0
      };
      growl.info("This page uses angular growl for notifications");
      var bar = Restangular.one("meta").one("cvabar", "tasks-bar");
      bar.get().then(function(d) {
        $scope.bar = d;
      });
      Restangular.one("data").all("task").getList().then(function(d) {
        $scope.tasks = d;
      });

      $scope.run = function(task) {
        Restangular.all("task").all(task).post().then(function(r) {
          console.log("TASK DONE");
          growl.success(r);

        }, function(r) {
          growl.error(r.data);
        })
      };

    } ])

// details of a task
.controller(
    "TaskCtrl",
    [ "$scope", "Restangular", "$stateParams", "growl",
        function($scope, Restangular, $stateParams, growl) {
          console.log("task control");
          var task = $stateParams.task;
          $scope.setTitle("Run Task" + task);
        } ])

// test update read and increment a counter
.controller("PostCtrl",
    [ "$scope", "Restangular", "growl", function($scope, Restangular, growl) {
      console.log("post control");
      $scope.get = function() {
        var _start = performance.now();
        Restangular.one("ping").get().then(function(r) {
          var _time = Math.floor(performance.now() - _start);
          growl.success(r, {
            title : 'GET  ' + _time + ' ms.'
          });
        });
      };
      $scope.incr = function() {
        var _start = performance.now();
        Restangular.all("ping").post().then(function(r) {
          var _time = Math.floor(performance.now() - _start);
          growl.success(r, {
            title : 'POST  ' + _time + ' ms.'
          });
        });
      };
      $scope.model = [ {
        label : 'parent1',
        children : [ {
          label : 'child'
        } ]
      }, {
        label : 'parent2',
        children : [ {
          label : 'child',
          children : [ {
            label : 'innerChild'
          } ]
        } ]
      }, {
        label : 'parent3'
      } ];
      $scope.expandFn = function(item) {
        var t = $scope.$expanded;
        growl.info("expand: " + item.label + " " + t);
        return true;
      };
    } ]);
