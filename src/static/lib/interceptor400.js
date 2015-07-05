// global 400 handler
//	http://stackoverflow.com/questions/11971213/error-401-handling-with-angularjs
// http://www.webdeveasy.com/interceptors-in-angularjs-and-useful-examples/
angular.module('quodatum.Error', [])

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
        err = response.data
        $location.path("/404")
        alert("Error (code=" + status + ") : " + response.data);
      }
      ;
      if (status == 404) {
        var deferred = $q.defer();
        var req = {
          config : response.config,
          deferred : deferred
        }
        err = response.data
        $location.path("/404")
        alert("Error (code=404) : " + response.data);
      }
    }
  };
  return trap;
} ])