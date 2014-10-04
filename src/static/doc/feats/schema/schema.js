// database info
angular.module('quodatum.doc.schema', [ 'restangular'])

.config(
		[ '$routeProvider', function($routeProvider) {
			console.log("$routeProvider quodatum.doc.schema");
			$routeProvider.when('/schema', {
				templateUrl : '/static/doc/feats/schema/schema.xhtml',
				controller : "SchemaCtrl"
			});

		} ])

// controllers
.controller("SchemaCtrl", [ "$scope","$resource","apiRoot", function($scope,$resource,apiRoot) {

	console.log("SchemaCtrl2");
	$scope.input={file:"Bill",schema:"schema/one"};
	$scope.report="the results";
	$scope.onfile=function(context){
	//	alert("file:"+context.selectedNode.$model.path);
		$scope.report=$scope.input.file+"###"+$scope.input.schema;
	};
	$scope.onschema=function(context){
	//	alert("schema:"+context.selectedNode.$model.path);
		$scope.report=$scope.input.file+"###"+$scope.input.schema;
	};
	$scope.go=function(){
		alert("go");
	};
} ])
;
