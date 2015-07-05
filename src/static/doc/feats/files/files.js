// database info
angular.module('quodatum.doc.files', [ 'ui.router', 'restangular' ]).config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('files', {
            url : "/files",
            templateUrl : '/static/doc/feats/files/files.xhtml',
            reloadOnSearch : false,
            controller : "FilesCtrl"
          })

        } ])

// controllers
.controller(
    "FilesCtrl",
    [ "$scope", "$resource", "$location", "apiRoot",
        function($scope, $resource, $stateParams, $location, apiRoot) {
          var target = "../../doc/data/file/read";

          // $scope.path = $stateParams.path?$stateParams.path:'';
          $scope.tabs = [ {
            title : 'Dynamic Title 1',
            content : 'Dynamic content 1'
          }, {
            title : 'Dynamic Title 2',
            content : 'Dynamic content 2',
            disabled : true
          } ];
          $scope.fred = "FRED";
          $scope.include = target + "?path=" + $scope.path;
          $scope.fsel = function(context) {
            var p = context.selectedNode.$model.path;
            // $location.search('path', p);
            $scope.path = p;
            $scope.include = target + "?path=" + $scope.path;
          };

        } ]);
