// database info
angular.module('quodatum.entity', [ 'ui.router','restangular','quodatum.directives'])
.config(
  [ '$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {
              $stateProvider

              .state('entity', {
                url : "/data/entity",
                abstract : true,
                template : '<ui-view>entity</ui-view>',
                ncyBreadcrumb: { skip:true},
                data:{entity:"entity"}
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
.controller("EntityListCtrl", [  '$stateParams', '$scope','$location','Restangular',
                                 'DiceService',
           function( $stateParams, $scope,$location,Restangular,
               DiceService) {
	
	console.log("EntityListCtrl");
	
	function update() {       
             Restangular.one("data").all('entity')
			            .getList($scope.params)
			            .then(function(d){
			            	// console.log("models..",d);
			            	$scope.models=d;
			            	});			 
    };
    DiceService.setup($scope,update)
  
}])
// controllers
.controller("FieldListCtrl", [  '$stateParams', '$scope','$location',
                                'Restangular','DiceService',
				           function($stateParams, $scope, $location,  Restangular,
				               DiceService) {
    var model= $stateParams.model;
	console.log("FieldListCtrl",model);

	function update() {       
             Restangular.one("data").one('entity',model)
			            .getList("field")
			            .then(function(d){
			            	console.log("fields..",d);
			            	$scope.fields=d;
			            	});			 
    };
    DiceService.setup($scope,update)
}])		
// controllers
.controller("EntityCtrl", [  '$scope','$stateParams','Restangular',
                             'DiceService',
           function( $scope, $stateParams,Restangular,DiceService) {
	
	console.log("ModelCtrl");
	Restangular.one("data")
			 .one("entity", $stateParams.model).get()
			 .then(function(d){$scope.model=d});
	  Restangular.one("data").one('entity',$stateParams.model)
	    .getList("field")
	    .then(function(d){
	        console.log("fields..",d);
	        $scope.fields=d;
	        });         
	
}])
.controller("FieldCtrl", [  '$scope','$stateParams','Restangular',
                            'DiceService',
           function( $scope, $stateParams,Restangular,DiceService) {
	
	console.log("FieldCtrl");
	Restangular.one("data")
                 .one("entity", $stateParams.model).get()
                 .then(function(d){$scope.model=d});
	
}])		