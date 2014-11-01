// database info
angular.module('quodatum.doc.directives', [ 'restangular' ])

.config([ '$routeProvider', function($routeProvider) {
	console.log("$routeProvider quodatum.doc.tests");
	$routeProvider.when('/directives', {
		templateUrl : '/static/doc/feats/directives/tests.xhtml',
		reloadOnSearch:false,
		controller : "TestCtrl"
	});

} ])

// controllers
.controller("TestCtrl", [ "$scope", "$anchorScroll",
                           function($scope,$anchorScroll) {
	console.log("testcontrol");
	$scope.scrollTo = function(id) {
		$location.hash(id);
		$anchorScroll();
	};
	$scope.list=[{name:'sortui'},{name:'uipage'},{name:'filepick'}];
	$scope.path="/test";
	$scope.options=["aa","bb","aaaaa"];
	$scope.fsel=function(){
	alert("hi");	
	};
	$scope.sortopts=["aa","bb"];
}]);	
