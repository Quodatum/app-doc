// database info
angular.module('quodatum.doc.schema', [ 'restangular' ])

.config([ '$routeProvider', function($routeProvider) {
	console.log("$routeProvider quodatum.doc.schema");
	$routeProvider.when('/schema', {
		templateUrl : '/static/doc/feats/schema/schema.xhtml',
		controller : "SchemaCtrl"
	});

} ]).factory('Validate',
		[ '$resource', "apiRoot", function($resource, apiRoot) {
			return {
				api : $resource(apiRoot + 'validate')
			}
		} ])
// controllers
.controller(
		"SchemaCtrl",
		[
				"$scope",
				"$resource",
				"apiRoot",
				'Validate',
				function($scope, $resource, apiRoot, Validate) {

					console.log("SchemaCtrl2");
					$scope.input = {
						xml : "Bill",
						schema : "schema/one"
					};
					$scope.report = "the results";
					$scope.onxml = function(context) {
						// alert("file:"+context.selectedNode.$model.path);
						$scope.report = $scope.input.xml + "###"
								+ $scope.input.schema;
					};
					$scope.onschema = function(context) {
						// alert("schema:"+context.selectedNode.$model.path);
						$scope.report = $scope.input.xml + "###"
								+ $scope.input.schema;
					};
					$scope.go = function() {
						Validate.api.get($scope.input).$promise.then(function(
								result) {
							$scope.result = result;
							console.log("val", result);
						});
					};
				} ]);