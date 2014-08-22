angular.module('doc', [ 'ngRoute', 
                        'ui.bootstrap',
                        'restangular',
                        'quodatum.doc.apps',
                        'quodatum.doc.components'])

.constant(
		"apiRoot", "../../doc/").config(
		[ '$routeProvider', '$locationProvider',
				function($routeProvider, $locationProvider) {
					console.log("APP config");
					$routeProvider.when('/', {
						redirectTo : '/components'
					}).when('/search', {
						templateUrl : '/static/doc/partials/search.xhtml',
						controller : "SearchCtrl"
					}).when('/404', {
						templateUrl : '/static/doc/partials/404.xhtml'
					}).when('/error', {
						templateUrl : '/static/doc/partials/error.xhtml'
					}).otherwise({
						redirectTo : '/404'
					});
					// use the HTML5 History API
					//$locationProvider.html5Mode(true);
				} ])

.config(
		[
				'RestangularProvider',
				function(RestangularProvider) {
					console.log("RestangularProvider config");
					RestangularProvider.setBaseUrl('../../doc/');
					RestangularProvider.setResponseExtractor(function(response,
							operation, what, url) {
						var data = response;
						// if list get item array, stash metadata
						// https://github.com/mgonto/restangular/issues/16
						if (operation === "getList") {
							data = response.items;
							data.metadata = {
								count : response.total,
								crumbs : response.crumbs
							}
						}
						return data;
					});
				} ])
				
				
.controller("AppController", [ "$scope", function($scope) {
	console.log("AppController");
}])
;
