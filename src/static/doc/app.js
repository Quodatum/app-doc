angular.module(
    'doc',
    [ 'ui.router', 'ngResource', 'ngAnimate','ngSanitize', 'ui.bootstrap', 'restangular',
        'ya.treeview', 'ya.treeview.tpls', 'angular-growl', 'ncy-angular-breadcrumb',
        'twygmbh.auto-height',
		'quodatum.entity','quodatum.doc.tasks',
        'quodatum.doc.apps', 'quodatum.doc.components', 'quodatum.doc.files',
        'quodatum.doc.xqm', 'quodatum.doc.schema', 'quodatum.doc.directives',
        'quodatum.doc.tools', 'quodatum.directives', 'quodatum.config' , 'quodatum.history'])

.constant("apiRoot", "../../doc/")

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider
		  
          .state('home', {
            url : "",
            controller : "HomeCtrl",
            data : {
              "history" : false
            }
          })
		  
          .state('search', {
            url : "/search?q",
            templateUrl : '/static/doc/templates/search.xhtml',
            controller : "SearchCtrl"
          })

          .state('error', {
            url : "/error",
            templateUrl : '/static/doc/templates/error.xhtml'
          })

          .state('about', {
            url : "/about",
            templateUrl : '/static/doc/templates/about.xhtml',
			 ncyBreadcrumb: { label: 'Home',icon:'glyphicon glyphicon-home'},
			 controller : "AboutCtrl",
			 data : {
	              "history" : false
	            }
          })

          .state('404', {
            url : "*path",
            templateUrl : '/static/doc/templates/404.xhtml',
            data : {
              "history" : false
            }
          });
        //  $urlRouterProvider.when('', '/about');  
         // $urlRouterProvider.otherwise('/404');  
          // use the HTML5 History API
          // $locationProvider.html5Mode(true);
        } ])
		
.controller("HomeCtrl",
    [ "$scope", "$location", function($scope, $location) {
      console.log("HomeCtrl");
     $location.path('/about')
    } ])

.controller("AboutCtrl",
    [ "Restangular","$scope",  function(Restangular,$scope) {
      //console.log("AboutCtrl");
     Restangular.oneUrl("status").get().then(function(d){
       console.log("res",d);
       $scope.version=d.version;
     });
    } ])
    
.controller("AppController",
    [ "$scope", "$location", function($scope, $location) {
      console.log("AppController");
      $scope.search = {};
      $scope.doSearch = function() {
        $location.path("/search").search({
          q : $scope.search.q
        });
      };
    } ])

.controller(
    "SearchCtrl",
    [ 'Restangular', '$location', '$scope', '$stateParams',
        function(Restangular, $location, $scope, $stateParams) {
          console.log("Search Init", $stateParams);
          $scope.search.q = $stateParams.q;
          function search(q) {
            console.log("search:",$scope.search );
            Restangular.all("search").getList({
              q : $scope.search.q
            }).then(function(d) {
              console.log(d);
              $scope.results = d;
            })
          }
          ;

          $scope.doSearch = function() {
            search($scope.search.q);
          };
          search($scope.search.q);
        } ])

        ;
