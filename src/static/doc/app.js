angular.module(
		'doc',
		[ 'ngRoute', 'ngResource', 'ngAnimate',
  		'ui.bootstrap', 'restangular',
		'ya.treeview', 'ya.treeview.tpls','angular-growl', 
		'quodatum.entity','quodatum.doc.apps', 'quodatum.doc.components',
		'quodatum.doc.files', 'quodatum.doc.schema',
		'quodatum.doc.directives', 'quodatum.doc.tools',
		'quodatum.directives' ])

.constant("apiRoot", "../../doc/").config(
		[ '$routeProvider', '$locationProvider',
				function($routeProvider, $locationProvider) {
					console.log("APP config");
					$routeProvider.when('/', {
						redirectTo : '/apps/doc'
					}).when('/search', {
						templateUrl : '/static/doc/templates/search.xhtml',
						controller : "SearchCtrl"
					}).when('/404', {
						templateUrl : '/static/doc/templates/404.xhtml'
					}).when('/about', {
						templateUrl : '/static/doc/templates/about.xhtml'
					}).when('/error', {
						templateUrl : '/static/doc/templates/error.xhtml'
					}).otherwise({
						redirectTo : '/404'
					});
					// use the HTML5 History API
					// $locationProvider.html5Mode(true);
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
							};
						}
						return data;
					});
				} ])

.run([ "$rootScope", "$window", function($rootScope, $window) {
	$rootScope.setTitle = function(t) {
		$window.document.title = t;
	};
} ])

.controller("AppController",
		[ "$scope", "$location", function($scope, $location) {
			console.log("AppController");
			$scope.search = {};
			$scope.doSearch = function() {
				$location.path("/search").search({
					q : $scope.search.q
				});
			};
		} ])

.controller(
		"SearchCtrl",
		[  'Restangular','$location', '$scope', '$routeParams',
				function(Restangular,$location, $scope, $routeParams) {
					console.log("Search", $routeParams);
					$scope.q = $routeParams.q;
					function search(q){
						Restangular.all("search").getList({q : $scope.q})
							.then(function(d){
								console.log(d);
								$scope.results=d;
							})
					};
					
					$scope.submit = function() {
						$location.path("/search");
					};
					$scope.doSearch = function() {
						search($scope.q);
					};
					search($scope.q);
				} ])
// information about entity
.factory('Entities', [ function() {
	console.log("entities");
	var ents = {
		"database" : [ {
			label : "name",
			field : "name"
		}, {
			label : "resources",
			field : "resources"
		}, {
			label : "updated",
			field : "updated"
		}, {
			label : "path",
			field : "path"
		} ],
		"model" : [ {
			label : "name",
			field : "name"
		}, {
			label : "type",
			field : "type"
		}, {
			label : "#field",
			field : "nfields"
		} ],
		"package" : [ {
			label : "name",
			field : "name"
		}, {
			label : "type",
			field : "type"
		} ],
		"resource" : [ {
			label : "name",
			field : "name"
		}, {
			label : "raw",
			field : "raw"
		}, {
			label : "modifiedDate",
			field : "modifiedDate"
		}, {
			label : "contentType",
			field : "contentType"
		} ],
		"log" : [ {
			label : "date",
			field : "date"
		}, {
			label : "size",
			field : "size"
		} ],
		"logentry" : [ {
			label : "Time",
			field : "time"
		}, {
			label : "Address",
			field : "address"
		}, {
			label : "User",
			field : "user"
		}, {
			label : "Type",
			field : "type"
		}, {
			label : "Ms",
			field : "ms"
		}, {
			label : "Message",
			field : "message"
		} ],
		"session" : [ {
			label : "id",
			field : "id"
		}, {
			label : "accessed",
			field : "accessed"
		}, {
			label : "created",
			field : "created"
		}, {
			label : "count",
			field : "count"
		} ],
		"endpoint" : [ {
			label : "path",
			field : "path"
		}, {
			label : "method",
			field : "method"
		}, {
			label : "doc",
			field : "doc"
		}, {
			label : "mediatype",
			field : "mediatype"
		} ],
		"xqmodule" : [ {
			label : "name",
			field : "name"
		}, {
			label : "description",
			field : "description"
		} ]
	};
	return {
		// sortable columns
		columns : function(entity) {
			return ents[entity]
		}
	}
} ]);
