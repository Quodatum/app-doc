// database info
angular.module('quodatum.doc.schema', [ 'ui.router' ])
.config(
  [ '$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {
              $stateProvider

              .state('schema', {
                url : "/schema",
                templateUrl : '/static/doc/feats/schema/schema.xhtml',
                controller : "SchemaCtrl"
              })
              

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
						xml : "doc/data/doc/models/entity.xml",
						schema : "static/schemas/entity.xsd"
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
						Validate.api.query($scope.input).$promise.then(function(
								result) {
							$scope.report = result;
							console.log("val", result);
						});
					};
					$scope.set = function() {
					  $scope.input = {xml : "/set/path"};
                  };
				} ]);