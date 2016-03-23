angular.module(
		'quodatum.services',
		[ 'restangular' ])

// sets hash and scrolls to      
.service('ScrollService', 
    ['$location','$anchorScroll','$log',
                           function($location,$anchorScroll,$log){
    this.scrollTo = function(id) {
      $log.log("ScrollService: ", id);
      $location.hash(id);
      // call $anchorScroll()
      $anchorScroll();
    };
}])

// setup dice parameters call update on change
// http://stackoverflow.com/a/22899880/3210344
.factory('DiceService', ['Restangular','$location', function (Restangular,$location) {
return {
    setup: function($scope,update){
      $scope.params = {start : 1,sort : "name"}; //q added by filter
      
      $scope.$watch('params', function(value) {
         $location.search($scope.params);
         update();
     }, true);
    },
    one:function(entity,name){
      return Restangular.one("data").one(entity).one('item', name).get();
    },
    list:function(entity,params){
      return Restangular.one("data").all(entity).getList(params);
    }
};     
}])
 
 // controllers
    .controller(
        // provides scrolling controller 
        // uses params app,view
        // to set inc also sets scrollTo
        "ScrollCtrl",
        [ '$stateParams', '$scope', 'ScrollService',
            function($stateParams, $scope, ScrollService) {

              console.log("Scroll controller: ",$stateParams);
              // $scope.setTitle("Coomponents");
			  if($stateParams.app){
              $scope.inc='/doc/app/' + $stateParams.app + '/view/'+$stateParams.view;
			  }else{
			   $scope.inc='/doc/wadl';
			  };
              $scope.scrollTo = ScrollService.scrollTo;

            } ])
            
            
// http://odetocode.com/blogs/scott/archive/2014/09/10/a-journey-with-trusted-html-in-angularjs.aspx
.directive("compileHtml", function($parse, $sce, $compile) {
    return {
        restrict: "A",
        link: function (scope, element, attributes) {
 
            var expression = $sce.parseAsHtml(attributes.compileHtml);
 
            var getResult = function () {
                return expression(scope);
            };
 
            scope.$watch(getResult, function (newValue) {
                var linker = $compile(newValue);
                element.append(linker(scope));
            });
        }
    }
})


;

