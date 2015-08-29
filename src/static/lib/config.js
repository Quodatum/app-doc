// Standard config for core components
// adds http error handler
// http://www.webdeveasy.com/interceptors-in-angularjs-and-useful-examples/

angular.module(
    'quodatum.config',
    [ 'ngSanitize', 'restangular', 'ui.router', 'angular-growl',
        'ncy-angular-breadcrumb', 'ngdexie', 'ngdexie.ui' ])

.config(function($httpProvider) {
  $httpProvider.interceptors.push('Interceptor400');
})

// register the interceptor as a service, intercepts ALL angular ajax http calls
.factory('Interceptor400', [ '$q', '$location', function($q, $location) {
  var trap = {
    responseError : function(response) {
      var status = response.status;
      if (status == 500) {
        var deferred = $q.defer();
        var req = {
          config : response.config,
          deferred : deferred
        }
        $location.path("/404");
        alert("Error (code=" + status + ") : " + response.data);
      }
      ;
      if (status == 404) {
        var deferred = $q.defer();
        var req = {
          config : response.config,
          deferred : deferred
        }
        $location.path("/404");
        alert("Error (code=404) : " + response.data);
      }
    }
  };
  return trap;
} ])

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

.config(function($breadcrumbProvider) {
  $breadcrumbProvider.setOptions({
    prefixStateName : 'about',
    // template: '<ol class="breadcrumb">'+
    // '<li ng-repeat="step in steps" ng-class="{active: $last}"
    // ng-switch="$last || !!step.abstract">'+
    // '<i class="{{step.ncyBreadcrumbIcon}}"></i><a ng-switch-when="false"
    // href="{{step.ncyBreadcrumbLink}}">{{step.ncyBreadcrumbLabel}}</a>'+
    // '<span ng-switch-when="true">{{step.ncyBreadcrumbLabel}}</span>'+
    // '</li>'+
    // '</ol>'
    template : "bootstrap3"
  });
})

// save state changes to indexeddb
.config(function(ngDexieProvider) {
  ngDexieProvider.setOptions({
    name : 'doc',
    debug : false
  });
  ngDexieProvider.setConfiguration(function(db) {
    db.version(1).stores({
      log : "++id,timestamp,state,params",
    });
    db.on('error', function(err) {
      // Catch all uncatched DB-related errors and exceptions
      console.error("db error err=" + err);
    });
  });
})

.run([ "$rootScope", "$window", function($rootScope, $window) {
  $rootScope.setTitle = function(t) {
    $window.document.title = t;
  };
} ])

// ui-router
.run(
    [
        '$rootScope',
        '$state',
        '$stateParams',
        'ngDexie',
        function($rootScope, $state, $stateParams, ngDexie) {

          // It's very handy to add references to $state and $stateParams to the
          // $rootScope
          // so that you can access them from any scope within your
          // applications.For
          // example,
          // <li ng-class="{ active: $state.includes('contacts.list') }"> will
          // set the
          // <li>
          // to active whenever 'contacts.list' or one of its decendents is
          // active.
          $rootScope.$state = $state;
          $rootScope.$stateParams = $stateParams;

          $rootScope.$on('$stateNotFound', function(event, unfoundState,
              fromState, fromParams) {
            console.log(unfoundState.to); // "lazy.state"
            console.log(unfoundState.toParams); // {a:1, b:2}
            console.log(unfoundState.options); // {inherit:false} + default
            // options
          });

          $rootScope.$on("$stateChangeError", console.log.bind(console));

          $rootScope.$on('$stateChangeSuccess', function(event, toState,
              toParams, fromState, fromParams) {
            // log all unless data.history:false
            if (toState.data ? toState.data.history : true) {
              var note = {
                timestamp : new Date().getTime(),
                state : toState.name,
                params : toParams
              };

              ngDexie.put('log', note).then(function() {
                // alert('Saved log');
              });
            }
          });
        }

    ]).filter('to_trusted', [ '$sce', function($sce) {
  return function(text) {
    return $sce.trustAsHtml(text);
  };
} ])