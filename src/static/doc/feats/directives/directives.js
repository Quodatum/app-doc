// database info
angular.module('quodatum.doc.directives', [ 'restangular' ])

.config([ '$routeProvider', function($routeProvider) {
	$routeProvider.when('/directives', {
		templateUrl : '/static/doc/feats/directives/tests.xhtml',
		reloadOnSearch : false,
		controller : "TestCtrl"
	});

} ])

// controllers
.controller(
		"TestCtrl",
		[ "$scope", "$location", "$anchorScroll","Restangular",
				function($scope, $location, $anchorScroll,Restangular) {
					console.log("testcontrol");
					$scope.scrollTo = function(id) {
						$location.hash(id);
						$anchorScroll();
					};
					$scope.list = [ {
						name : 'sortui'
					}, {
						name : 'uipage'
					}, {
						name : 'filepick'
					}, {
						name : 'cva'
					} ];
					
					var bar = Restangular.one("meta").one("cvabar","test-bar");
					bar.get().then(function(d) {
						$scope.bar = d;
					});
					
					$scope.path = "/test";
					$scope.fsel = function() {
						alert("hi");
					};

					$scope.params = {
						sort : "-bb"
					}
					$scope.options = [ "aa", "bb", "aaaaa" ];

				} ])
;
