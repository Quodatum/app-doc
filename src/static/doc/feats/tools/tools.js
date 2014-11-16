// database info
angular.module('quodatum.doc.tools', [ 'restangular', 'angular-growl' ])

.config([ '$routeProvider', function($routeProvider) {
	console.log("$routeProvider quodatum.doc.tests");
	$routeProvider.when('/tasks', {
		templateUrl : '/static/doc/feats/tools/tasks.xhtml',
		reloadOnSearch : false,
		controller : "TaskCtrl"
	}).when('/poster', {
		templateUrl : '/static/doc/feats/tools/poster.xhtml',
		reloadOnSearch : false,
		controller : "PostCtrl"
	});

} ])

// controllers
.controller(
		"TaskCtrl",
		[
				"$scope",
				"Restangular",
				"growl",
				function($scope, Restangular, growl) {
					console.log("task control");
					$scope.setTitle("Run Tasks");
					growl.info("This page uses angular growl for notifications");
					$scope.tasks = [ {
						name : "1"
					}, {
						name : "2"
					} ];
					$scope.run = function(task) {
						Restangular.all("task").all(task).post().then(
								function(r) {
									console.log("TASK DONE");
									growl.success(r);

								}, function(r) {
									growl.error(r.data);
								})
					};

				} ])

.controller("PostCtrl", [ "$scope", 
                          "Restangular",
                          "growl",
                          function($scope,Restangular,growl) {
	console.log("post control");
	$scope.get = function() {
		var _start = performance.now();
		Restangular.one("ping").get().then(function(r) {
			var _time = Math.floor(performance.now()- _start);
			growl.success(r,{title:'GET  ' + _time + ' ms.'});
		});
	};
	$scope.incr = function() {
		var _start = performance.now();
		Restangular.all("ping").post().then(function(r) {
			var _time = Math.floor(performance.now()- _start);
			growl.success(r,{title:'POST  ' + _time + ' ms.'});
		});
	};
} ]);
