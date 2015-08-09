// database info
angular.module('quodatum.entity', [ 'ui.router','restangular'])
.config(
  [ '$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {
              $stateProvider

              .state('entity', {
                url : "/data/entity",
                abstract : true,
                template : '<ui-view>entity</ui-view>',
                ncyBreadcrumb: { skip:true}
              })
              
              .state('entity.index', {
                url : "",
                templateUrl : '/static/doc/feats/entity/entitylist.xml',
                controller : "EntityListCtrl",
                 reloadOnSearch: false, 
                 ncyBreadcrumb: { label: 'Entities'}
              })
              
              .state('entity.model', {
                url : "/:model",
                templateUrl : '/static/doc/feats/entity/entity1.xml',
                controller : "EntityCtrl",
                ncyBreadcrumb: { label: '{{$stateParams.model}}',parent: 'entity.index'}
              })
              
              .state('entity.model.fields', {
                url : "/fields",
                templateUrl : '/static/doc/feats/entity/fieldlist.xml',
                controller : "FieldListCtrl",
                 reloadOnSearch: false,
                 ncyBreadcrumb: { label: 'Fields'}
              })
              
  .state('entity.model.fields.item', {
                url : "/:field",
                templateUrl : '/static/doc/feats/entity/field1.xml',
                controller : "FieldCtrl",
                ncyBreadcrumb: { label: 'field:{{model.name}}'}
              })
            } ])
            
// controllers
.controller("EntityListCtrl", [  '$stateParams', '$scope','$location','$modal','Restangular',
                                 'Entities',
           function( $stateParams, $scope,$location,$modal,Restangular,
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
			            	// console.log("models..",d);
			            	$scope.models=d;
			            	});			 
    };
}])
// controllers
.controller("FieldListCtrl", [  '$stateParams', '$scope','$location','$modal',
                                'Restangular','Entities',
				           function($stateParams, $scope, $location, $modal, Restangular,
						Entities) {
	$scope.sortopts=Entities.columns("model");
    $scope.params = {start : 0,sort : "name"};
    var model= $stateParams.model;
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
.controller("EntityCtrl", [  '$scope','$stateParams','$modal','Restangular',
                             'Entities',
           function( $scope, $stateParams,$modal,Restangular,Entities) {
	
	console.log("ModelCtrl");
	Restangular.one("data")
			 .one("entity", $stateParams.model).get()
			 .then(function(d){$scope.model=d});
	
}])
.controller("FieldCtrl", [  '$scope','$stateParams','$modal','Restangular',
                            'Entities',
           function( $scope, $stateParams,$modal,Restangular,Entities) {
	
	console.log("FieldCtrl");
	Restangular.one("data")
                 .one("entity", $stateParams.model).get()
                 .then(function(d){$scope.model=d});
	
}])		