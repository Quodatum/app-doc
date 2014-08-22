// database info
angular.module('quodatum.doc.components', [ 'restangular'])
.config(
        [ '$routeProvider', 
		function($routeProvider) {
        	console.log("quodatum.doc.components $routeProvider")
           $routeProvider.when('/components', {
               templateUrl : '/static/doc/feats/components/components.xhtml',
               controller : "CmpCtrl"
           });  

      }])
 

// controllers
.controller("CmpCtrl", [  '$routeParams', '$scope','$location',
                             '$modal','Restangular','$http',
           function( $routeParams, $scope,$location,$modal,Restangular,
        		   $http) {
	
	console.log("CmpCtrl");
	

}])
;
          