// database info
angular.module('quodatum.doc.components', [ 'ui.router', 'quodatum.services' ])

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider

          .state('component', {
            url : "/data/component",
            abstract : true,
            ncyBreadcrumb : {
              skip : true
            },
            template : '<ui-view>library</ui-view>',
            data : {
              entity : "component"
            }
          })

          .state('component.index', {
            url : "",
            templateUrl : '/static/doc/feats/components/components.html',
            ncyBreadcrumb : {
              label : 'components'
            },
            controller : "CompsCtrl",
            data : {
              entity : "component"
            }
          })

          .state('component.item', {
            url : "/item/:name",
            templateUrl : '/static/doc/feats/components/comp1.html',
            ncyBreadcrumb : {
              label : '{{$stateParams.name}}',
              parent : 'component.index'
            },
            controller : "CompCtrl"
          })

          .state('component.tree', {
            url : "/tree",
            templateUrl : '/static/doc/feats/components/cmptree.html',
            controller : "TreeCtrl",
            ncyBreadcrumb : {
              label : 'tree',
              parent : 'component.index'
            }
          })

          .state('component.version', {
            url : "/version",
            abstract : true,
            ncyBreadcrumb : {
              skip : true
            },
            template : '<ui-view>library</ui-view>',
            data : {
              entity : "component.version"
            }
          })
          
          .state('component.version.index', {
            url : "",
            templateUrl : '/static/doc/feats/components/versions.html',
            ncyBreadcrumb : {
                label : 'versions',
                parent : 'component.index'
            },
            controller : "VersCtrl",
          })
          
          .state('component.basex', {
            url : "/basex",
            abstract : true,
            ncyBreadcrumb : {
              skip : true,
              data : {
                entity : "xqmodule"
              }
            },
            template : '<ui-view>basex</ui-view>'
          })

          .state('component.basex.index', {
            url : "",
            templateUrl : '/static/doc/feats/components/basex.xhtml',
            controller : "BasexCtrl",
            ncyBreadcrumb : {
              label : 'basex modules'
            }
          })

          .state('component.basex.module', {
            url : "/module?name",
            templateUrl : '/static/doc/feats/components/basex.xhtml',
            controller : "BasexCtrl",
            ncyBreadcrumb : {
              label : '{{$stateParams.name}}',
              parent : 'component.basex.index'
            }
          })

          .state('endpoint', {
            url : "/data/endpoint",
            templateUrl : '/static/doc/feats/components/wadl-view.xhtml',
            ncyBreadcrumb : {
              label : 'endpoint'
            },
            controller : "ScrollCtrl",
            data : {
              entity : "endpoint"
            }

          })
        } ])

.factory('API', [ '$resource', "apiRoot", function($resource, apiRoot) {
  return {
    basex : $resource(apiRoot + 'components/basex')
  }
} ])

// controllers
.controller("CmptreeCtrl", [ '$scope', function($scope) {
  console.log("svg here");
} ])

.controller("TreeCtrl", [ '$scope', function($scope) {
  console.log("TreeCtrl", $scope.$stateParams);
  var panZoom;
  $scope.gotsvg = function() {
    var svg = document.getElementById("svghere").querySelector('svg');
    panZoom = svgPanZoom(svg, {
      zoomEnabled : true,
      controlIconsEnabled : true,
      fit : true,
      center : true,
      minZoom : 0.1
    });
  };

  $scope.zoomIn = function(ev) {
    ev.preventDefault();
    panZoom.zoomIn();
  };
  $scope.zoomOut = function(ev) {
    ev.preventDefault();
    panZoom.zoomOut();
  };
  $scope.zoomReset = function(ev) {
    ev.preventDefault();
    panZoom.resetZoom();
  };
} ])

// show BaseX system modules
.controller(
    "BasexCtrl",
    [ '$scope', '$stateParams', 'DiceService',
        function($scope, $stateParams, DiceService) {

          function update() {
            DiceService.list('xqmodule', $scope.params).then(function(d) {
              $scope.apps = d;
            });
          }
          DiceService.setup($scope, update);
        } ])

.controller(
    // provides scrolling controller
    // uses params app,view
    // to set inc also sets scrollTo
    "CICtrl",
    [ '$stateParams', '$scope', '$http', '$sce', 'ScrollService',
        function($stateParams, $scope, $http, $sce, ScrollService) {

          console.log("CI controller: ", ScrollService);
          // $scope.setTitle("Coomponents");
          // http://localhost:8984/doc/components/browser?fmt=html
          $http.get('components/browser?fmt=json').then(function(response) {
            $scope.cmphtml = $sce.trustAsHtml(response.data.html);
          });

          $scope.scrollTo = ScrollService.scrollTo;

        } ])

.controller(
    // provides dice scrolling controller for components
    "CompsCtrl",
    [ '$stateParams', '$scope', 'DiceService',
        function($stateParams, $scope, DiceService) {

          console.log("CompsCtrl: ", $stateParams);
          function update() {
            DiceService.list("component", $scope.params).then(function(d) {
              $scope.apps = d;
            });
          }
          ;
          DiceService.setup($scope, update);
        } ])

 .controller(
    // provides dice scrolling controller for components
    "VersCtrl",
    [ '$stateParams', '$scope', 'DiceService',
        function($stateParams, $scope, DiceService) {

          console.log("VersCtrl: ", $stateParams);
          function update() {
            DiceService.list("component.version", $scope.params).then(function(d) {
              $scope.apps = d;
            });
          }
          ;
          DiceService.setup($scope, update);
        } ]) 
        
// controller for component=name
.controller(
    "CompCtrl",
    [ 'DiceService', '$stateParams', '$scope',
        function(DiceService, $stateParams, $scope) {
          console.log("CompCtrl");
          var name = $stateParams.name;
          var applist = DiceService.one('component', name);
          applist.then(function(d) {
            $scope.item = d;
            console.log(">>CompCtrl", d);
          });
        } ]);
