// database info
angular.module('quodatum.doc.directives', [ 'ui.router','restangular', 'angular-growl' ])
.config(   [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('directives', {
            url : "/directives",
		templateUrl : '/static/doc/feats/directives/tests.xhtml',
		reloadOnSearch : false,
		controller : "TestCtrl"
	});

} ])

// controllers
.controller(
		"TestCtrl",
		[ "$scope", "$location", "$anchorScroll","Restangular","growl",
				function($scope, $location, $anchorScroll,Restangular,growl) {
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
					$scope.endpoint='data/file/list';
					var bar = Restangular.one("meta").one("cvabar","test-bar");
					bar.get().then(function(d) {
						$scope.bar = d;
					});
					
					$scope.path = "/test";
					$scope.fsel = function() {
						growl.info("onselect event");
					};

					$scope.params = {
						sort : "-bb"
					}
					$scope.options = [ "aa", "bb", "aaaaa" ];

				} ])
;
