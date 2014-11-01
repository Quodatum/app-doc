// database info
angular.module('quodatum.doc.tools', [ 'restangular' ])

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
.controller("TaskCtrl", [ "$scope", function($scope) {
	console.log("task control");

} ])

.controller("PostCtrl", [ "$scope", function($scope) {
	console.log("post control");
} ]);
