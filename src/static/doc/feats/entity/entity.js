// database info
angular.module('quodatum.entity', [ 'restangular'])
.config(
        [ '$routeProvider', 
		function($routeProvider) {
           $routeProvider.when('/data/entity', {
               templateUrl : '/static/doc/feats/entity/entitylist.xml',
               controller : "EntityListCtrl",
				reloadOnSearch: false	    	
           }).when('/data/entity/:model', {
               templateUrl : '/static/doc/feats/entity/entity1.xml',
               controller : "EntityCtrl"	    	
		    }).when('/data/entity/:model/fields', {
               templateUrl : '/static/doc/feats/entity/fieldlist.xml',
               controller : "FieldListCtrl",
				reloadOnSearch: false
			 }).when('/data/entity/:model/fields/:field', {
               templateUrl : '/static/doc/feats/entity/field1.xml',
               controller : "FieldCtrl"	      
           })
      }])
// controllers		
.controller("EntityListCtrl", [  '$routeParams', '$scope','$location','$modal','Restangular',
                                 'Entities',
           function( $routeParams, $scope,$location,$modal,Restangular,
        		   Entities) {
	$scope.sortopts=Entities.columns("model");
    $scope.params = {start : 0,sort : "name"};
   
	console.log("ModelListCtrl");
	$scope.$watch('params', function(value) {
        $location.search($scope.params);
        update();
    }, true);
	function update() {       
             Restangular.one("data").all('entity')
			            .getList($scope.params)
			            .then(function(d){
			            	//console.log("models..",d);
			            	$scope.models=d;
			            	});			 
    };
}])
// controllers		
.controller("FieldListCtrl", [  '$routeParams', '$scope','$location','$modal',
                                'Restangular','Entities',
				           function($routeParams, $scope, $location, $modal, Restangular,
						Entities) {
	$scope.sortopts=Entities.columns("model");
    $scope.params = {start : 0,sort : "name"};
    var model= $routeParams.model;
	console.log("FieldListCtrl");
	$scope.$watch('params', function(value) {
        $location.search($scope.params);
        update();
    }, true);
	function update() {       
             Restangular.one("data").one('entity',model)
			            .getList("fields")
			            .then(function(d){
			            	console.log("fields..",d);
			            	$scope.fields=d;
			            	});			 
    };
}])		
// controllers		
.controller("EntityCtrl", [  '$scope','$routeParams','$modal','Restangular',
                             'Entities',
           function( $scope, $routeParams,$modal,Restangular,Entities) {
	
	console.log("ModelCtrl");
	Restangular.one("data")
			 .one("entity", $routeParams.model).get()
			 .then(function(d){$scope.model=d});
	
}])
.controller("FieldCtrl", [  '$scope','$routeParams','$modal','Restangular',
                            'Entities',
           function( $scope, $routeParams,$modal,Restangular,Entities) {
	
	console.log("FieldCtrl");
	Restangular.one("data")
                 .one("entity", $routeParams.model).get()
                 .then(function(d){$scope.model=d});
	
}])		