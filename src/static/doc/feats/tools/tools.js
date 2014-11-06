// database info
angular.module('quodatum.doc.tools', [ 'restangular','angular-growl' ])

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
.controller("TaskCtrl", [ "$scope","Restangular", "growl",
                          function($scope, Restangular,growl)  {
	console.log("task control");
	$scope.setTitle("Run Tasks");
	growl.addWarnMessage("This adds a warn message");
	$scope.tasks=[{name:"1"},{name:"2"}];
	$scope.run=function(task){
		Restangular.all("task").all(task).post().then(function(r){
			console.log("TASK DONE");
		})
	};

} ])

.controller("PostCtrl", [ "$scope", function($scope) {
	console.log("post control");
} ]);
