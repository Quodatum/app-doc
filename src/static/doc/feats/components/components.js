// database info
angular.module('quodatum.doc.components', [ ])
.config(
        [ '$routeProvider', 
		function($routeProvider) {
        	console.log("quodatum.doc.components $routeProvider")
           $routeProvider.when('/components', {
               templateUrl : '/static/doc/feats/components/components.xhtml',
               controller : "CmpCtrl"
           }).when('/components/tree', {
               templateUrl : '/static/doc/feats/components/cmptree.xhtml',
               controller : "CmptreeCtrl"
           }).when('/components/basex', {
               templateUrl : '/static/doc/feats/components/basex.xhtml',
               controller : "BasexCtrl"
           })
           ;  

      }])
 

// controllers
.controller("CmpCtrl", [  '$routeParams', '$scope','$location',
                             '$http','$anchorScroll',
           function( $routeParams, $scope,$location,
        		   $http,$anchorScroll) {
	
	console.log("CmpCtrl");
	//$scope.setTitle("Coomponents");
	
	$scope.scrollTo = function(id) {
		//$log.log("DDDD", id);
		$location.hash(id);
		// call $anchorScroll()
		$anchorScroll();
	};		

}])

.controller("CmptreeCtrl", ['$scope',function($scope){
	
}])

.controller("BasexCtrl", ['$scope',function($scope){
	$scope.module="admin.xqm"
}])
;
          