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
.controller("SchemaCtrl", [ "$scope", function($scope) {

	console.log("SchemaCtrl2");
	

} ]);
