// database info
angular.module('quodatum.doc.components', ['quodatum.services' ])
.config(
        [ '$routeProvider', 
		function($routeProvider) {
           $routeProvider.when('/data/component', {
               templateUrl : '/static/doc/feats/components/components.xhtml',
               controller : "CmpCtrl"
           }).when('/data/component/tree', {
               templateUrl : '/static/doc/feats/components/cmptree.xhtml',
               controller : "CmptreeCtrl"
           }).when('/data/component/basex', {
               templateUrl : '/static/doc/feats/components/basex.xhtml',
               controller : "BasexCtrl"
           })
           ;  

      }])


.factory('API',
        [ '$resource',  "apiRoot", function($resource, apiRoot) {
            return {
                basex : $resource(apiRoot + 'components/basex')
            }
        } ])
        
// controllers
.controller("CmpCtrl", [  '$routeParams', '$scope','ScrollService',                          
           function( $routeParams, $scope,ScrollService) {
	
	console.log("CmpCtrlXX");
	// $scope.setTitle("Coomponents");
	
	$scope.scrollTo = ScrollService.scrollTo;

}])

.controller("CmptreeCtrl", ['$scope',function($scope){
  console.log("svg here");
}])

// show BaseX system modules
.controller("BasexCtrl", ['$scope','$routeParams','API','ScrollService',
                          function($scope,$routeParams,API,ScrollService){
	console.log("BasexCtrl");
	$scope.module = $routeParams.module;
	$scope.isModule=!!$scope.module;
	if(!$scope.isModule){
		$scope.results=API.basex.query();
		$scope.module="admin.xqm"
	};
	$scope.scrollTo = ScrollService.scrollTo;
	
}])
;
          