// database info
angular.module('quodatum.doc.files', [ 'restangular' ])

.config([ '$routeProvider', function($routeProvider) {
	console.log("$routeProvider quodatum.doc.files");
	$routeProvider.when('/files', {
		templateUrl : '/static/doc/feats/files/files.xhtml',
		reloadOnSearch:false,
		controller : "FilesCtrl"
	});

} ])

// controllers
.controller("FilesCtrl", [ "$scope", "$resource","$location","apiRoot",
                           function($scope,$resource,$routeParams,$location,apiRoot) {
	var target="../../doc/data/file/read";
	
	$scope.path = $routeParams.path;
	$scope.include=target+"?path="+$scope.path;
	$scope.fsel=function(context){
		var p=context.selectedNode.$model.path;
	
		$scope.path=p;
		$scope.include=target+"?path="+$scope.path;
	};
	
}]);	
