// database info
angular.module('quodatum.doc.apps', [ 'restangular'])

.config(
		[ '$routeProvider', function($routeProvider) {
			console.log("$routeProvider quodatum.doc.apps");
			$routeProvider.when('/apps', {
				templateUrl : '/static/doc/feats/apps/apps.xhtml',
				controller : "AppsCtrl"
			});

		} ])

// controllers
.controller("AppsCtrl", [ "$scope", function($scope) {

	console.log("AppsCtrl2");
	

} ]);
