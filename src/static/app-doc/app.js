var App=angular.module('palmyra', ['ngRoute',       
	'ui.bootstrap','ui.ace','flashr','ui.layout','treeControl',
	'restangular','abp.angular.xslt','apb.angular.tree' ]
)
.constant("apiRoot","../../palmyra/")
.config( [ '$routeProvider', 
          function($routeProvider) {
            console.log("APP config");
             $routeProvider.when('/',{redirectTo : '/xslt'})
              .when('/search', {
                 templateUrl : '/static/palmyra/partials/search.xhtml',
                 controller :"SearchCtrl"
             }).when('/404', {
                 templateUrl : '/static/palmyra/partials/404.xhtml'
             }).when('/error', {
                 templateUrl : '/static/palmyra/partials/error.xhtml'		
             }).otherwise({
                 redirectTo : '/404'
             });
        }])
.config([  'RestangularProvider', 
           function(RestangularProvider) {
    			console.log("RestangularProvider config");
		  		  RestangularProvider.setBaseUrl('../../palmyra/');
				  RestangularProvider.setResponseExtractor(function(response, operation, what, url) {
		        var data=response;
				// if list get item array, stash metadata 
				// https://github.com/mgonto/restangular/issues/16
				if(operation==="getList"){
				  data=response.items;
				  data.metadata={count:response.total,
				                 crumbs:response.crumbs}
				}  
				return data;
		});
        }]);
//set height on element to extend to window
//http://stackoverflow.com/questions/14703517/angular-js-set-element-height-on-page-load
App.directive('fillheight', function ($window) {
 return function (scope, element) {
     var w = angular.element($window);
		var e=$(element);
     scope.getWindowDimensions = function () {
          var x=e.offset();
		    // console.log("--",element,"xxxxx:",x);
         return { 'h': w.height(), 'w': w.width(),"top":x.top };
     };
		
     scope.$watch(scope.getWindowDimensions, function (newValue, oldValue) {
         scope.windowHeight = newValue.h;
         scope.windowWidth = newValue.w;
         scope.style = function () {
             return { 
                 'height': (newValue.h - newValue.top -60) + 'px',
                 'min-height': '200px' 
					
             };
         };

     }, true);

     w.bind('resize', function () {
         scope.$apply();
     });
 }});
App.controller("AppController", ["$scope","$location","flashr",
  function($scope,$location,flashr) {
	console.log("AppController");
	flashr.now.success("loaded")
}])
