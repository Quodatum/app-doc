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
    [ "$scope",   function($scope) {
      console.log("comp control");
    }])
    
// test update read and increment a counter
.controller("PostCtrl",
    [ "$scope", "Restangular","StatsService",function($scope, Restangular,StatsService) {
      console.log("post control");
      $scope.getCount=StatsService.getInstance();
      $scope.postCount=StatsService.getInstance();
      $scope.get = function() {
        var _start = performance.now();
        return Restangular.one("ping").get().then(function(r) {
          var v=Math.floor(performance.now() - _start);
          $scope.getValues =  $scope.getCount.log(v);;
          $scope.repeat.count=r;
          if($scope.repeat.get){
            $scope.get(); //does this leak??
          }
         });
      };
    
      $scope.incr = function() {
        var _start = performance.now();
        return Restangular.all("ping").post().then(function(r) {
          var v= Math.floor(performance.now() - _start);

          $scope.postValues =  $scope.postCount.log(v);;
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

// track max,min,avg
.service('StatsService', [ function() { 
  var aCounter = function() {   
  var data={count:0,max:null,min:null,total:0,median:0};
  this.log=function(val){
    data.last=val;
    data.total+=val;
    data.count+=1;
    if(data.count==1){
      data.max=val;
      data.min=val;
     data.median=val;
    }else{
      if(val<data.min)data.min=val;
      if(val>data.max)data.max=val;
    };
    //https://jeremykun.com/2012/06/14/streaming-median/
    if (data.median > val)
      data.median-= 1
    else if( data.median < val)
      data.median += 1;

    data.avg=data.total / data.count;
   // console.log("stats",data);
    return data;
  };
  this.clear=function(){
    data={count:0,max:null,min:null,total:0};
  };
  this.values=function(){
    return data;
  };

  };
  return {
    getInstance: function () {
      return new aCounter();
    }
};
}])

;