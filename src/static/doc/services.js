angular.module(
		'quodatum.services',
		[  ])

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

 // controllers
    .controller(
        // provides scrolling controller
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
});

