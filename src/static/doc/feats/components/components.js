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
                data:{entity:"component"}
              })

              .state('component.index', {
                url : "",
                templateUrl : '/static/doc/feats/components/components.xhtml',
                ncyBreadcrumb : {
                  label : 'components'
                },
                controller : "CICtrl",
                data:{entity:"component"}
              })

              .state('component.item', {
                url : "/item/:name",
                templateUrl : '/static/doc/feats/components/comp1.xhtml',
                ncyBreadcrumb : {
                  label : '{{$stateParams.name}}',
                  parent : 'component.index'
                },
                controller : "CompCtrl"
              })

              .state('component.tree', {
                url : "/tree",
                templateUrl : '/static/doc/feats/components/cmptree.xhtml',
                controller : "TreeCtrl",
                ncyBreadcrumb : {
                  label : 'tree',
                  parent : 'component.index'
                }
              })

              .state('component.basex', {
                url : "/basex",
                abstract : true,
                ncyBreadcrumb : {
                  skip : true
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
                data:{entity:"endpoint"}

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

    // controllers
    .controller("CompCtrl", [ '$scope', function($scope) {
      console.log("CompCtrl");
    } ])

    .controller("TreeCtrl", [ '$scope', function($scope) {
      console.log("TreeCtrl", $scope.$stateParams);
      var panZoom;
      $scope.gotsvg = function() {
        var svg = document.getElementById("svghere").querySelector('svg');
        panZoom= svgPanZoom(svg, {
          zoomEnabled : true,
          controlIconsEnabled : true,
          contain:true
        });
      };
      
      $scope.zoomIn = function(ev){
        ev.preventDefault();
        panZoom.zoomIn();
      };
      $scope.zoomOut = function(ev){
        ev.preventDefault();
        panZoom.zoomOut();
      };
      $scope.zoomReset = function(ev){
        ev.preventDefault();
        panZoom.zoomReset();
      };
    } ])

    // show BaseX system modules
    .controller(
        "BasexCtrl",
        [ '$scope', '$stateParams', 'API', 'ScrollService',
            function($scope, $stateParams, API, ScrollService) {
              console.log("BasexCtrl");
              $scope.module = $stateParams.name;
              $scope.isModule = !!$scope.module;
              if (!$scope.isModule) {
                $scope.results = API.basex.query();
                $scope.module = "admin.xqm"
              }
              ;
              $scope.scrollTo = ScrollService.scrollTo;

            } ])
            

    .controller(
        // provides scrolling controller 
        // uses params app,view
        // to set inc also sets scrollTo
        "CICtrl",
        [ '$stateParams', '$scope', '$http','$sce','ScrollService',
            function($stateParams, $scope, $http,$sce,ScrollService) {

              console.log("CI controller: ",$stateParams);
              // $scope.setTitle("Coomponents");
              //http://localhost:8984/doc/components/browser?fmt=html
                $http.get('components/browser?fmt=json').then(function(response) {
                  $scope.cmphtml = $sce.trustAsHtml(response.data.html);
              });
              
              $scope.scrollTo = ScrollService.scrollTo;

            } ])            
            ;
