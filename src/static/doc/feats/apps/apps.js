// database info
angular.module('quodatum.doc.apps', [ 'restangular'])

.config(
		[ '$routeProvider', function($routeProvider) {
			console.log("$routeProvider quodatum.doc.apps");
			$routeProvider.when('/apps', {
				templateUrl : '/static/doc/feats/apps/apps.xhtml',
				controller : "AppsCtrl"
			}).when('/apps/:app', {
                templateUrl : '/static/doc/feats/apps/app1.xhtml',
                controller : "AppCtrl"
			})
			;

		} ])

// controllers
.controller("AppsCtrl", [ "$scope","Restangular", function($scope,Restangular) {

	console.log("AppsCtrl2");
	var applist = Restangular.one("data").all('app');
	applist.getList().then(function(d){
		console.log("AppsCtrl2",d);
		$scope.apps=d;
	});

} ])

.controller("AppCtrl", [ "$scope","$routeParams","Restangular",
                         function($scope,$routeParams,Restangular) {
	console.log("AppsCtrl");
	var item = $routeParams.app;
	var applist = Restangular.one("data").all('app');
	applist.getList().then(function(d){
		console.log("AppsCtrl",d);
		$scope.apps=d;
	});

} ])
;
