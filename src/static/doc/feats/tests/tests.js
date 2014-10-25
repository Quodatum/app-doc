// database info
angular.module('quodatum.doc.tests', [ 'restangular' ])

.config([ '$routeProvider', function($routeProvider) {
	console.log("$routeProvider quodatum.doc.tests");
	$routeProvider.when('/tests', {
		templateUrl : '/static/doc/feats/tests/tests.xhtml',
		reloadOnSearch:false,
		controller : "TestCtrl"
	});

} ])

// controllers
.controller("TestCtrl", [ "$scope", "$resource","$routeParams","$location","apiRoot",
                           function($scope,$resource,$routeParams,$location,apiRoot) {
	console.log("testcontrol");
	$scope.path="/test";
	$scope.fsel=function(){
	alert("hi");	
	};
	$scope.sortopts=["aa","bb"];
}]);	
