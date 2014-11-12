// database info
angular.module('quodatum.doc.components', [ ])
.config(
        [ '$routeProvider', 
		function($routeProvider) {
           $routeProvider.when('/data/component-js', {
               templateUrl : '/static/doc/feats/components/components.xhtml',
               controller : "CmpCtrl"
           }).when('/data/component-js/tree', {
               templateUrl : '/static/doc/feats/components/cmptree.xhtml',
               controller : "CmptreeCtrl"
           }).when('/data/component-js/basex', {
               templateUrl : '/static/doc/feats/components/basex.xhtml',
               controller : "BasexCtrl"
           })
           ;  

      }])
 
.factory('Basex',
        [ '$resource',  "apiRoot", function($resource, apiRoot) {
            return {
                api : $resource(apiRoot + 'components/basex')
            }
        } ])
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

// show BaseX system modules
.controller("BasexCtrl", ['$scope','$routeParams','Basex',function($scope,$routeParams,Basex){
	console.log("BasexCtrl");
	$scope.module = $routeParams.module;
	$scope.isModule=!!$scope.module;
	if(!$scope.isModule){
		$scope.results=Basex.api.query();
		$scope.module="admin.xqm"
	};
	
	
}])
;
          