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

