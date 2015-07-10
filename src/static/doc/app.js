angular.module(
    'doc',
    [ 'ui.router', 'ngResource', 'ngAnimate','ngSanitize', 'ui.bootstrap', 'restangular',
        'ya.treeview', 'ya.treeview.tpls', 'angular-growl', 'ncy-angular-breadcrumb',
		'quodatum.entity',
        'quodatum.doc.apps', 'quodatum.doc.components', 'quodatum.doc.files',
        'quodatum.doc.xqm', 'quodatum.doc.schema', 'quodatum.doc.directives',
        'quodatum.doc.tools', 'quodatum.directives', 'quodatum.config' ])

.constant("apiRoot", "../../doc/")

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('search', {
            url : "/search",
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
			 ncyBreadcrumb: { label: 'BOUT',icon:'glyphicon glyphicon-home'}
          })

          .state('404', {
            url : "/404",
            templateUrl : '/static/doc/templates/404.xhtml'
          });
          $urlRouterProvider.when('', '/about');  
          $urlRouterProvider.otherwise('/404');  
          // use the HTML5 History API
          // $locationProvider.html5Mode(true);
        } ])
/*
.config(
    [
        'RestangularProvider',
        function(RestangularProvider) {
          console.log("RestangularProvider config");
          RestangularProvider.setBaseUrl('.');
          RestangularProvider.setResponseExtractor(function(response,
              operation, what, url) {
            var data = response;
            // if list get item array, stash metadata
            // https://github.com/mgonto/restangular/issues/16
            if (operation === "getList") {
              data = response.items;
              data.metadata = {
                count : response.total,
                crumbs : response.crumbs
              };
            }
            return data;
          });
        } ])
// growl
.config([ 'growlProvider', function(growlProvider) {
  growlProvider.globalPosition('bottom-right');
  growlProvider.globalTimeToLive({
    success : 5000,
    error : -1,
    warning : 3000,
    info : 1000
  });
} ])

.run([ "$rootScope", "$window", function($rootScope, $window) {
  $rootScope.setTitle = function(t) {
    $window.document.title = t;
  };
} ])

// ui-router
.run(
  [ '$rootScope', '$state', '$stateParams',
    function ($rootScope,   $state,   $stateParams) {

    // It's very handy to add references to $state and $stateParams to the
    // $rootScope
    // so that you can access them from any scope within your applications.For
    // example,
    // <li ng-class="{ active: $state.includes('contacts.list') }"> will set the
    // <li>
    // to active whenever 'contacts.list' or one of its decendents is active.
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
    

    $rootScope.$on('$stateNotFound', 
    function(event, unfoundState, fromState, fromParams){ 
        console.log(unfoundState.to); // "lazy.state"
        console.log(unfoundState.toParams); // {a:1, b:2}
        console.log(unfoundState.options); // {inherit:false} + default options
    });
    
    $rootScope.$on("$stateChangeError", console.log.bind(console));
    }
  ]
)
 .filter('to_trusted', ['$sce', function($sce){
        return function(text) {
            return $sce.trustAsHtml(text);
        };
    }])
    
*/    
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
          console.log("Search", $stateParams);
          $scope.q = $stateParams.q;
          function search(q) {
            Restangular.all("search").getList({
              q : $scope.q
            }).then(function(d) {
              console.log(d);
              $scope.results = d;
            })
          }
          ;

          $scope.submit = function() {
            $location.path("/search");
          };
          $scope.doSearch = function() {
            search($scope.q);
          };
          search($scope.q);
        } ])
// information about entity
.factory('Entities', [ function() {
  console.log("entities");
  var ents = {
    "database" : [ {
      label : "name",
      field : "name"
    }, {
      label : "resources",
      field : "resources"
    }, {
      label : "updated",
      field : "updated"
    }, {
      label : "path",
      field : "path"
    } ],
    "model" : [ {
      label : "name",
      field : "name"
    }, {
      label : "type",
      field : "type"
    }, {
      label : "#field",
      field : "nfields"
    } ],
    "package" : [ {
      label : "name",
      field : "name"
    }, {
      label : "type",
      field : "type"
    } ],
    "resource" : [ {
      label : "name",
      field : "name"
    }, {
      label : "raw",
      field : "raw"
    }, {
      label : "modifiedDate",
      field : "modifiedDate"
    }, {
      label : "contentType",
      field : "contentType"
    } ],
    "log" : [ {
      label : "date",
      field : "date"
    }, {
      label : "size",
      field : "size"
    } ],
    "logentry" : [ {
      label : "Time",
      field : "time"
    }, {
      label : "Address",
      field : "address"
    }, {
      label : "User",
      field : "user"
    }, {
      label : "Type",
      field : "type"
    }, {
      label : "Ms",
      field : "ms"
    }, {
      label : "Message",
      field : "message"
    } ],
    "session" : [ {
      label : "id",
      field : "id"
    }, {
      label : "accessed",
      field : "accessed"
    }, {
      label : "created",
      field : "created"
    }, {
      label : "count",
      field : "count"
    } ],
    "endpoint" : [ {
      label : "path",
      field : "path"
    }, {
      label : "method",
      field : "method"
    }, {
      label : "doc",
      field : "doc"
    }, {
      label : "mediatype",
      field : "mediatype"
    } ],
    "xqmodule" : [ {
      label : "name",
      field : "name"
    }, {
      label : "description",
      field : "description"
    } ]
  };
  return {
    // sortable columns
    columns : function(entity) {
      return ents[entity]
    }
  }
} ]);
