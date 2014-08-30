angular.module('doc', [ 'ngRoute', 'ngResource',
                        'ui.bootstrap',
                        'restangular',
                        'oci.treeview',
                        'ya.treeview','ya.treeview.tpls',
                        'quodatum.doc.apps',
                        'quodatum.doc.components',
                        'quodatum.doc.files'])

.constant(
		"apiRoot", "../../doc/").config(
		[ '$routeProvider', '$locationProvider',
				function($routeProvider, $locationProvider) {
					console.log("APP config");
					$routeProvider.when('/', {
						redirectTo : '/components'
					}).when('/search', {
						templateUrl : '/static/doc/templates/search.xhtml',
						controller : "SearchCtrl"
					}).when('/404', {
						templateUrl : '/static/doc/templates/404.xhtml'
					}).when('/error', {
						templateUrl : '/static/doc/templates/error.xhtml'
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
					RestangularProvider.setBaseUrl('.');
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
				
				
.controller("AppController", [ "$scope","$location", function($scope,$location) {
	console.log("AppController");
	$scope.search={};
	 $scope.doSearch=function(){
         $location.path("/search").search({q: $scope.search.q});
     };
}])

.factory('Search',
        [ '$resource', '$http', "apiRoot", function($resource, $http, apiRoot) {
            return {
                api : $resource(apiRoot + 'search?q=:q')
            }
        } ])
        
.controller("SearchCtrl", [ 'Search', '$location', '$scope', '$routeParams',
		function(Search, $location, $scope, $routeParams) {
			console.log("Search",$routeParams);
			$scope.q = $routeParams.q;
			$scope.results = Search.api.query({
				q : $scope.q
			});
			$scope.submit = function() {
				$location.path("/search");
			};
			$scope.doSearch = function() {
				$scope.results = Search.api.query({
					q : $scope.q
				});
			};
		} ])
		
;
