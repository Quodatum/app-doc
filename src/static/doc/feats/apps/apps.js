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
.controller("AppsCtrl", [ "$scope","Restangular", function($scope,Restangular) {

	console.log("AppsCtrl2");
	var applist = Restangular.one("data").all('app');

} ]);
