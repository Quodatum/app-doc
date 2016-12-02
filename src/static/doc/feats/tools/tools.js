// database info
angular.module('quodatum.doc.tools',
    [ 'ui.router', 'restangular', 'angular-growl', 'treemendous','ui.bootstrap'  ])

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('poster', {
            url : "/poster",
            templateUrl : '/static/doc/feats/tools/poster.xhtml',
            reloadOnSearch : false,
            controller : "PostCtrl"
          })
          
        .state('comps', {
            url : "/comps",
            templateUrl : '/static/doc/feats/tools/comps.xhtml',
            reloadOnSearch : false,
            controller : "CmpCtrl"
          })
        } ])

// controllers
.controller("CmpCtrl",
    [ "$scope", "Restangular", "growl", function($scope, Restangular, growl) {
      console.log("comp control");
    }])
    
// test update read and increment a counter
.controller("PostCtrl",
    [ "$scope", "Restangular", "growl", function($scope, Restangular, growl) {
      console.log("post control");
      $scope.get = function() {
        var _start = performance.now();
        return Restangular.one("ping").get().then(function(r) {
          $scope.getMs= Math.floor(performance.now() - _start);
          $scope.repeat.count=r;
          if($scope.repeat.get){
            $scope.get(); //does this leak??
          }
         });
      };
    
      $scope.incr = function() {
        var _start = performance.now();
        return Restangular.all("ping").post().then(function(r) {
          $scope.postMs = Math.floor(performance.now() - _start);
          $scope.repeat.count=r;
          if($scope.repeat.post){
            $scope.incr();
          }
        })
      };
      $scope.repeat ={get:false,
                     post:false,
                     count:null
      };
  
      $scope.model = [ {
        label : 'parent1',
        children : [ {
          label : 'child'
        } ]
      }, {
        label : 'parent2',
        children : [ {
          label : 'child',
          children : [ {
            label : 'innerChild'
          } ]
        } ]
      }, {
        label : 'parent3'
      } ];
      $scope.expandFn = function(item) {
        var t = $scope.$expanded;
        growl.info("expand: " + item.label + " " + t);
        return true;
      };
    } ])
;